defmodule Stellar.XDR.Int32 do
  @moduledoc """
  Representation of Stellar `Int32` type.
  """

  @behaviour XDR.Declaration

  @spec new(integer()) :: XDR.Int.t()
  defdelegate new(num), to: XDR.Int

  @impl true
  defdelegate encode_xdr(int_32), to: XDR.Int

  @impl true
  defdelegate encode_xdr!(int_32), to: XDR.Int

  @impl true
  defdelegate decode_xdr(bytes, term \\ nil), to: XDR.Int

  @impl true
  defdelegate decode_xdr!(bytes, term  \\ nil), to: XDR.Int
end

defmodule Stellar.XDR.Int64 do
  @moduledoc """
  Representation of Stellar `Int64` type.
  """

  @behaviour XDR.Declaration

  @spec new(integer()) :: XDR.HyperInt.t()
  defdelegate new(num), to: XDR.HyperInt

  @impl true
  defdelegate encode_xdr(int_64), to: XDR.HyperInt

  @impl true
  defdelegate encode_xdr!(int_64), to: XDR.HyperInt

  @impl true
  defdelegate decode_xdr(bytes, term \\ nil), to: XDR.HyperInt

  @impl true
  defdelegate decode_xdr!(bytes, term  \\ nil), to: XDR.HyperInt
end
