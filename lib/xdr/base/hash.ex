defmodule Stellar.XDR.Hash do
  @moduledoc """
  Representation of Stellar `Hash` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{hash: binary()}

  defstruct [:hash]

  @spec new(hash :: binary()) :: t()
  def new(hash), do: %__MODULE__{hash: hash}

  @impl true
  defdelegate encode_xdr(hash), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate encode_xdr!(hash), to: Stellar.XDR.Opaque32

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Stellar.XDR.Opaque32.decode_xdr(bytes) do
      {:ok, {%Stellar.XDR.Opaque32{opaque: hash}, rest}} -> {:ok, {new(hash), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Stellar.XDR.Opaque32{opaque: hash}, rest} = Stellar.XDR.Opaque32.decode_xdr!(bytes)
    {new(hash), rest}
  end
end
