defmodule StellarBase.StrKey do
  @moduledoc """
  Allows encoding and decoding signatures used in the Stellar network.
  """
  import Bitwise

  alias StellarBase.StrKeyError

  @type binary_data :: binary() | nil
  @type data :: String.t() | nil

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

  @spec encode(data :: binary_data(), version :: atom()) :: {:ok, String.t()} | {:error, atom()}
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

  @spec encode!(data :: binary_data(), version :: atom()) :: String.t() | no_return()
  def encode!(data, version) do
    case encode(data, version) do
      {:ok, key} -> key
      {:error, reason} -> raise(StrKeyError, reason)
    end
  end

  @spec decode(data :: String.t(), version :: atom()) :: {:ok, binary()} | {:error, atom()}
  def decode(nil, _version), do: {:error, :invalid_data}

  def decode(data, version) do
    version_bytes = Keyword.get(@version_bytes, version, :ed25519_public_key)

    <<decoded_version_bytes::size(8), decoded_data::binary-size(32),
      decoded_checksum::little-integer-size(16)>> = Base.decode32!(data)

    checksum = CRC.crc(:crc_16_xmodem, <<version_bytes>> <> decoded_data)

    with :ok <- validate_version_bytes(version_bytes, decoded_version_bytes),
         :ok <- validate_checksum(checksum, decoded_checksum) do
      {:ok, decoded_data}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec decode!(data :: data(), version :: atom()) :: binary() | no_return()
  def decode!(data, version) do
    case decode(data, version) do
      {:ok, key} -> key
      {:error, reason} -> raise(StrKeyError, reason)
    end
  end

  @spec validate_version_bytes(version :: integer(), decoded_version :: integer()) ::
          :ok | no_return()
  defp validate_version_bytes(version, version), do: :ok
  defp validate_version_bytes(_version, _decoded_version), do: {:error, :unmatched_version_byte}

  @spec validate_checksum(checksum :: integer(), decoded_checksum :: integer()) :: :ok
  defp validate_checksum(checksum, checksum), do: :ok
  defp validate_checksum(_checksum, _decoded_checksum), do: {:error, :invalid_checksum}
end
