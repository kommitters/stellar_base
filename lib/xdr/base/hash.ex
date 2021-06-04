defmodule Stellar.XDR.Hash do
  @moduledoc """
  Representation of Stellar `Hash` type.
  """

  @behaviour XDR.Declaration

  @spec new(binary()) :: XDR.FixedOpaque.t()
  defdelegate new(hash), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate encode_xdr(hash), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate encode_xdr!(hash), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate decode_xdr(bytes), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate decode_xdr!(bytes), to: Stellar.XDR.Opaque32
end
