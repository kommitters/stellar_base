defmodule StellarBase.Ed25519.SecretSeed do
  @moduledoc """
  Encode/decode functions for Ed25519 secret seeds.
  """
  import Bitwise

  alias StellarBase.Ed25519.StrKey

  # Secret keys starting with the letter S
  # 18 <<< 3: 144: S
  @version_bytes 18 <<< 3

  @spec encode!(data :: binary()) :: String.t()
  def encode!(data), do: StrKey.encode!(data, @version_bytes)

  @spec decode!(data :: String.t()) :: binary()
  def decode!(data), do: StrKey.decode!(data, @version_bytes)
end
