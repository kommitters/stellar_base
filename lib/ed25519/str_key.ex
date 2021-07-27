defmodule Stellar.Ed25519.StrKey do
  @moduledoc """
  Functions to encode/decode Ed25519 keys.
  """

  @spec encode!(data :: binary() | nil, version_bytes :: binary()) :: String.t()
  def encode!(nil, _version_bytes), do: raise(ArgumentError, "cannot encode nil data")

  def encode!(data, version_bytes) do
    payload = <<version_bytes>> <> data

    payload
    |> (&CRC.crc(:crc_16_xmodem, &1)).()
    |> (&(payload <> <<&1::little-16>>)).()
    |> Base.encode32(padding: false)
  end

  @spec decode!(data :: String.t() | nil, version_bytes :: binary()) :: binary()
  def decode!(nil, _version_bytes), do: raise(ArgumentError, "cannot decode nil data")

  def decode!(data, version_bytes) do
    <<decoded_version_bytes::size(8), decoded_data::binary-size(32),
      decoded_checksum::little-integer-size(16)>> = Base.decode32!(data)

    checksum = CRC.crc(:crc_16_xmodem, <<version_bytes>> <> decoded_data)

    with :ok <- validate_version_bytes!(version_bytes, decoded_version_bytes),
         :ok <- validate_checksum!(checksum, decoded_checksum) do
      decoded_data
    end
  end

  @spec validate_version_bytes!(version_bytes :: integer(), decoded_version_bytes :: integer()) ::
          :ok
  defp validate_version_bytes!(version_bytes, version_bytes), do: :ok

  defp validate_version_bytes!(version_bytes, decoded_version_bytes),
    do:
      raise(
        ArgumentError,
        "invalid version byte. Expected #{version_bytes}, got #{decoded_version_bytes}"
      )

  @spec validate_checksum!(checksum :: integer(), decoded_checksum :: integer()) :: :ok
  defp validate_checksum!(checksum, checksum), do: :ok

  defp validate_checksum!(_checksum, _decoded_checksum),
    do: raise(ArgumentError, "invalid checksum")
end
