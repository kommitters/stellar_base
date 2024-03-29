defmodule StellarBase.XDR.Opaque4 do
  @moduledoc """
  Representation of Stellar `Opaque4` type.
  """

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{opaque: binary()}

  defstruct [:opaque]

  @length 4
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @spec new(opaque :: binary()) :: t()
  def new(opaque), do: %__MODULE__{opaque: opaque}

  @impl true
  def encode_xdr(%__MODULE__{opaque: opaque}) do
    XDR.FixedOpaque.encode_xdr(%XDR.FixedOpaque{opaque: opaque, length: @length})
  end

  @impl true
  def encode_xdr!(%__MODULE__{opaque: opaque}) do
    XDR.FixedOpaque.encode_xdr!(%XDR.FixedOpaque{opaque: opaque, length: @length})
  end

  @impl true
  def decode_xdr(bytes, spec \\ @opaque_spec)

  def decode_xdr(bytes, spec) do
    case XDR.FixedOpaque.decode_xdr(bytes, spec) do
      {:ok, {%XDR.FixedOpaque{opaque: opaque}, rest}} -> {:ok, {new(opaque), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @opaque_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.FixedOpaque{opaque: opaque}, rest} = XDR.FixedOpaque.decode_xdr!(bytes, spec)
    {new(opaque), rest}
  end
end
