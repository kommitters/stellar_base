defmodule Stellar.Ed25519.PublicKey do
  @moduledoc """
  Encode/decode functions for Ed25519 public keys.
  """
  import Bitwise

  alias Stellar.Ed25519.StrKey

  # Public keys starting with the letter G
  # 6 <<< 3: 48: G
  @version_bytes 6 <<< 3

  @spec encode!(data :: binary()) :: String.t()
  def encode!(data), do: StrKey.encode!(data, @version_bytes)

  @spec decode!(data :: String.t()) :: binary()
  def decode!(data), do: StrKey.decode!(data, @version_bytes)
end
