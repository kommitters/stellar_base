defmodule StellarBase.StrKey do
  @moduledoc """
  Allows encoding and decoding signatures used in the Stellar network.
  """
  import Bitwise

  alias StellarBase.StrKeyError

  @type data :: String.t() | nil
  @type binary_data :: binary() | nil
  @type version_bytes :: integer()
  @type checksum :: integer()
  @type error :: {:error, atom()}
  @type validation :: :ok | error()
  @type decoded_components :: {:ok, {version_bytes(), binary(), checksum()}} | error()
  @type version ::
          :ed25519_public_key
          | :ed25519_secret_seed
          | :pre_auth_tx
          | :sha256_hash
          | :muxed_account

  @version_bytes [
    # Base32-encodes to 'G...'
    ed25519_public_key: 6 <<< 3,
    # Base32-encodes to 'S...'
    ed25519_secret_seed: 18 <<< 3,
    # Base32-encodes to 'T...'
    pre_auth_tx: 19 <<< 3,
    # Base32-encodes to 'X...'
    sha256_hash: 23 <<< 3,
    # Base32-encodes to 'M...'
    muxed_account: 12 <<< 3
  ]

  @spec encode(data :: binary_data(), version :: version()) ::
          {:ok, String.t()} | {:error, atom()}
  def encode(nil, _version), do: {:error, :invalid_binary}

  def encode(data, version) do
    version_bytes = Keyword.get(@version_bytes, version, :ed25519_public_key)
    payload = <<version_bytes>> <> data

    payload
    |> (&CRC.crc(:crc_16_xmodem, &1)).()
    |> (&(payload <> <<&1::little-16>>)).()
    |> Base.encode32(padding: false)
    |> (&{:ok, &1}).()
  end

  @spec encode!(data :: binary_data(), version :: version()) :: String.t() | no_return()
  def encode!(data, version) do
    case encode(data, version) do
      {:ok, key} -> key
      {:error, reason} -> raise(StrKeyError, reason)
    end
  end

  @spec decode(data :: data(), version :: version()) :: {:ok, binary()} | error()
  def decode(nil, _version), do: {:error, :cant_decode_nil_data}

  def decode(data, version) do
    version_bytes = Keyword.get(@version_bytes, version, :ed25519_public_key)

    with {:ok, {decoded_version_bytes, decoded_data, decoded_checksum}} <-
           decode_components(data),
         :ok <- validate_version_bytes(version_bytes, decoded_version_bytes),
         :ok <- validate_checksum(decoded_data, version_bytes, decoded_checksum) do
      {:ok, decoded_data}
    end
  end

  @spec decode!(data :: data(), version :: atom()) :: binary() | no_return()
  def decode!(data, version) do
    case decode(data, version) do
      {:ok, key} -> key
      {:error, reason} -> raise(StrKeyError, reason)
    end
  end

  @spec decode_components(data :: binary()) :: decoded_components()
  defp decode_components(data) do
    data
    |> Base.decode32(padding: false)
    |> validate_decoded_binary()
  end

  @spec validate_decoded_binary(data :: {:ok, binary()} | :error) :: decoded_components()
  defp validate_decoded_binary(
         {:ok,
          <<version_bytes::size(8), data::binary-size(40), checksum::little-integer-size(16)>>}
       ),
       do: {:ok, {version_bytes, data, checksum}}

  defp validate_decoded_binary(
         {:ok,
          <<version_bytes::size(8), data::binary-size(32), checksum::little-integer-size(16)>>}
       ),
       do: {:ok, {version_bytes, data, checksum}}

  defp validate_decoded_binary(_decoded_data), do: {:error, :invalid_data_to_decode}

  @spec validate_version_bytes(
          version_bytes :: version_bytes(),
          decoded_version :: version_bytes()
        ) :: validation()
  defp validate_version_bytes(version_bytes, version_bytes), do: :ok

  defp validate_version_bytes(_version_bytes, _decoded_version_bytes),
    do: {:error, :unmatched_version_bytes}

  @spec validate_checksum(
          decoded_data :: binary(),
          version_bytes :: version_bytes(),
          decoded_checksum :: checksum()
        ) :: validation()
  defp validate_checksum(decoded_data, version_bytes, decoded_checksum) do
    checksum = CRC.crc(:crc_16_xmodem, <<version_bytes>> <> decoded_data)
    if checksum == decoded_checksum, do: :ok, else: {:error, :invalid_checksum}
  end
end
