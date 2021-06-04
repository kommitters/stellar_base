defmodule Stellar.XDR.UInt32 do
  @moduledoc """
  Representation of Stellar `UInt32` type.
  """

  @behaviour XDR.Declaration

  @spec new(pos_integer()) :: XDR.UInt.t()
  defdelegate new(num), to: XDR.UInt

  @impl true
  defdelegate encode_xdr(uint_32), to: XDR.UInt

  @impl true
  defdelegate encode_xdr!(uint_32), to: XDR.UInt

  @impl true
  defdelegate decode_xdr(bytes, term \\ nil), to: XDR.UInt

  @impl true
  defdelegate decode_xdr!(bytes, term \\ nil), to: XDR.UInt
end

defmodule Stellar.XDR.UInt64 do
  @moduledoc """
  Representation of Stellar `UInt64` type.
  """

  @behaviour XDR.Declaration

  @spec new(pos_integer()) :: XDR.UInt.t()
  defdelegate new(num), to: XDR.HyperUInt

  @impl true
  defdelegate encode_xdr(uint_64), to: XDR.HyperUInt

  @impl true
  defdelegate encode_xdr!(uint_64), to: XDR.HyperUInt

  @impl true
  defdelegate decode_xdr(bytes, term \\ nil), to: XDR.HyperUInt

  @impl true
  defdelegate decode_xdr!(bytes, term \\ nil), to: XDR.HyperUInt
end

defmodule Stellar.XDR.UInt256 do
  @moduledoc """
  Representation of Stellar `UInt256` type.
  """

  @behaviour XDR.Declaration

  @spec new(pos_integer()) :: XDR.FixedOpaque.t()
  defdelegate new(opaque), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate encode_xdr(u_int_256), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate encode_xdr!(u_int_256), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate decode_xdr(bytes, term \\ nil), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate decode_xdr!(bytes, term \\ nil), to: Stellar.XDR.Opaque32
end
