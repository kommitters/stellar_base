defmodule Stellar.XDR.VariableOpaque64 do
  @moduledoc """
  Representation of Stellar `VariableOpaque64` type.
  """

  @behaviour XDR.Declaration

  @max_size 64
  @opaque_spec XDR.FixedOpaque.new(nil, @max_size)

  @spec new(opaque :: binary(), max_size :: pos_integer()) :: XDR.FixedOpaque.t()
  def new(opaque, max_size \\ @max_size) when max_size <= @max_size,
    do: XDR.VariableOpaque.new(opaque, max_size)

  @impl true
  defdelegate encode_xdr(variable_opaque), to: XDR.VariableOpaque

  @impl true
  defdelegate encode_xdr!(variable_opaque), to: XDR.VariableOpaque

  @impl true
  defdelegate decode_xdr(bytes, variable_opaque \\ @opaque_spec), to: XDR.VariableOpaque

  @impl true
  defdelegate decode_xdr!(bytes, variable_opaque \\ @opaque_spec), to: XDR.VariableOpaque
end
