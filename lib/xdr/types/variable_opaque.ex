defmodule StellarBase.XDR.VariableOpaque do
  @moduledoc """
  Representation of Stellar `VariableOpaque` type.
  """

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{opaque: binary()}

  defstruct [:opaque]

  @opaque_spec XDR.VariableOpaque.new(nil)
  @max_size 4_294_967_295

  @spec new(opaque :: binary()) :: t()
  def new(opaque), do: %__MODULE__{opaque: opaque}

  @impl true
  def encode_xdr(%__MODULE__{opaque: opaque}) do
    XDR.VariableOpaque.encode_xdr(%XDR.VariableOpaque{opaque: opaque, max_size: @max_size})
  end

  @impl true
  def encode_xdr!(%__MODULE__{opaque: opaque}) do
    XDR.VariableOpaque.encode_xdr!(%XDR.VariableOpaque{opaque: opaque, max_size: @max_size})
  end

  @impl true
  def decode_xdr(bytes, spec \\ @opaque_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableOpaque.decode_xdr(bytes, spec) do
      {:ok, {%XDR.VariableOpaque{opaque: opaque, max_size: @max_size}, rest}} ->
        {:ok, {new(opaque), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @opaque_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.VariableOpaque{opaque: opaque}, rest} = XDR.VariableOpaque.decode_xdr!(bytes, spec)
    {new(opaque), rest}
  end
end
