defmodule Stellar.StrKey do
  @moduledoc """
  Encode/decode functions Ed25519 key pairs.
  """

  import Bitwise

  @versions ~w(ed25519PublicKey ed25519SecretSeed)a

  # Public keys starting with the letter G
  # Secret starting with the letter S
  @version_bytes [
    ed25519PublicKey: 6 <<< 3,
    ed25519SecretSeed: 18 <<< 3
  ]

  @spec encode!(version_byte_name :: atom(), data :: binary()) :: String.t()
  def encode!(_version_byte_name, nil), do: raise(ArgumentError, "cannot encode nil data")

  def encode!(version_byte_name, _data) when version_byte_name not in @versions,
    do:
      raise(
        ArgumentError,
        "#{version_byte_name} is not a valid version byte name. Expected one of #{
          Enum.join(@versions, ", ")
        }."
      )

  def encode!(version_byte_name, data) do
    payload =
      @version_bytes
      |> Keyword.get(version_byte_name)
      |> (&(<<&1>> <> data)).()

    payload
    |> (&CRC.crc(:crc_16_xmodem, &1)).()
    |> (&(payload <> <<&1::little-16>>)).()
    |> Base.encode32(padding: false)
  end

  @spec decode!(version_byte_name :: atom(), data :: String.t()) :: binary()
  def decode!(version_byte_name, _data) when version_byte_name not in @versions,
    do:
      raise(
        ArgumentError,
        "#{version_byte_name} is not a valid version byte name. Expected one of #{
          Enum.join(@versions, ", ")
        }."
      )

  def decode!(version_byte_name, data) do
    <<version_byte::size(8), data::binary-size(32), checksum::little-integer-size(16)>> =
      Base.decode32!(data)

    version_byte
    |> valid_version_byte(version_byte_name)
    |> valid_checksum(checksum, data)
  end

  @spec valid_version_byte(version_byte :: binary(), version_byte_name :: binary()) :: binary()
  defp valid_version_byte(version_byte, version_byte_name) do
    expected_version = @version_bytes[version_byte_name]

    if version_byte != expected_version,
      do:
        raise(
          ArgumentError,
          "invalid version byte. Expected #{expected_version}, got #{version_byte}"
        ),
      else: version_byte
  end

  @spec valid_checksum(version_byte :: binary(), checksum :: binary(), data :: String.t()) ::
          binary()
  defp valid_checksum(version_byte, checksum, data) do
    expected_checksum = CRC.crc(:crc_16_xmodem, <<version_byte>> <> data)
    if checksum != expected_checksum, do: raise(ArgumentError, "invalid checksum"), else: data
  end
end
