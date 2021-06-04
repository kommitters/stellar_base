defmodule Stellar.XDR.Opaque4 do
  @moduledoc """
  Representation of Stellar `Opaque4` type.
  """

  @behaviour XDR.Declaration

  @length 4
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @spec new(binary()) :: XDR.FixedOpaque.t()
  def new(opaque), do: XDR.FixedOpaque.new(opaque, @length)

  @impl true
  defdelegate encode_xdr(fixed_opaque), to: XDR.FixedOpaque

  @impl true
  defdelegate encode_xdr!(fixed_opaque), to: XDR.FixedOpaque

  @impl true
  defdelegate decode_xdr(bytes, fixed_opaque \\ @opaque_spec), to: XDR.FixedOpaque

  @impl true
  defdelegate decode_xdr!(bytes, fixed_opaque \\ @opaque_spec), to: XDR.FixedOpaque
end

defmodule Stellar.XDR.Opaque12 do
  @moduledoc """
  Representation of Stellar `Opaque12` type.
  """

  @behaviour XDR.Declaration

  @length 12
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @spec new(binary()) :: XDR.FixedOpaque.t()
  def new(opaque), do: XDR.FixedOpaque.new(opaque, @length)

  @impl true
  defdelegate encode_xdr(fixed_opaque), to: XDR.FixedOpaque

  @impl true
  defdelegate encode_xdr!(fixed_opaque), to: XDR.FixedOpaque

  @impl true
  defdelegate decode_xdr(bytes, fixed_opaque \\ @opaque_spec), to: XDR.FixedOpaque

  @impl true
  defdelegate decode_xdr!(bytes, fixed_opaque \\ @opaque_spec), to: XDR.FixedOpaque
end

defmodule Stellar.XDR.Opaque32 do
  @moduledoc """
  Representation of Stellar `Opaque32` type.
  """

  @behaviour XDR.Declaration

  @length 32
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @spec new(binary()) :: XDR.FixedOpaque.t()
  def new(opaque), do: XDR.FixedOpaque.new(opaque, @length)

  @impl true
  defdelegate encode_xdr(fixed_opaque), to: XDR.FixedOpaque

  @impl true
  defdelegate encode_xdr!(fixed_opaque), to: XDR.FixedOpaque

  @impl true
  defdelegate decode_xdr(bytes, fixed_opaque \\ @opaque_spec), to: XDR.FixedOpaque

  @impl true
  defdelegate decode_xdr!(bytes, fixed_opaque \\ @opaque_spec), to: XDR.FixedOpaque
end
