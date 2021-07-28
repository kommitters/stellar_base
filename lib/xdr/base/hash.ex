defmodule Stellar.XDR.Hash do
  @moduledoc """
  Representation of Stellar `Hash` type.
  """
  alias Stellar.XDR.Opaque32

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{hash: binary()}

  defstruct [:hash]

  @spec new(hash :: binary()) :: t()
  def new(hash), do: %__MODULE__{hash: hash}

  @impl true
  def encode_xdr(%__MODULE__{hash: hash}) do
    Opaque32.encode_xdr(%Opaque32{opaque: hash})
  end

  @impl true
  def encode_xdr!(%__MODULE__{hash: hash}) do
    Opaque32.encode_xdr!(%Opaque32{opaque: hash})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Opaque32.decode_xdr(bytes) do
      {:ok, {%Opaque32{opaque: hash}, rest}} -> {:ok, {new(hash), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Opaque32{opaque: hash}, rest} = Opaque32.decode_xdr!(bytes)
    {new(hash), rest}
  end
end
