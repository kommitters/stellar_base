defmodule Stellar.XDR.Void do
  @moduledoc """
  Representation of Stellar `Void` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: nil}

  defstruct [:value]

  @spec new() :: t()
  def new, do: %__MODULE__{}

  @impl true
  def encode_xdr(%__MODULE__{}) do
    XDR.Void.encode_xdr(%XDR.Void{})
  end

  @impl true
  def encode_xdr!(%__MODULE__{}) do
    XDR.Void.encode_xdr!(%XDR.Void{})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.Void.decode_xdr(bytes) do
      {:ok, {nil, rest}} -> {:ok, {new(), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {nil, rest} = XDR.Void.decode_xdr!(bytes)
    {new(), rest}
  end
end
