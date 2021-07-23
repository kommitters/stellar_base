defmodule Stellar.XDR.Hash do
  @moduledoc """
  Representation of Stellar `Hash` type.
  """
  @behaviour XDR.Declaration

  @length 32
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @type t :: %__MODULE__{hash: binary()}

  defstruct [:hash]

  @spec new(hash :: binary()) :: t()
  def new(hash), do: %__MODULE__{hash: hash}

  @impl true
  def encode_xdr(hash) do
    hash
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr()
  end

  @impl true
  def encode_xdr!(hash) do
    hash
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @opaque_spec)

  def decode_xdr(bytes, spec) do
    case XDR.FixedOpaque.decode_xdr(bytes, spec) do
      {:ok, {%XDR.FixedOpaque{opaque: hash}, rest}} -> {:ok, {new(hash), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @opaque_spec)

  def decode_xdr!(bytes, spec) do
    with {%XDR.FixedOpaque{opaque: hash}, rest} <- XDR.FixedOpaque.decode_xdr!(bytes, spec) do
      {new(hash), rest}
    end
  end
end
