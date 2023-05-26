defmodule StellarBase.XDR.String do
  @moduledoc """
  Representation of Stellar `String` type.
  """

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: string()}

  defstruct [:value]

  @spec new(value :: string()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    value
    |> XDR.String.new()
    |> XDR.String.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    value
    |> XDR.String.new()
    |> XDR.String.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.String.decode_xdr(bytes) do
      {:ok, {%XDR.String{string: value}, rest}} -> {:ok, {new(value), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.String{string: value}, rest} = XDR.String.decode_xdr!(bytes)
    {new(value), rest}
  end
end
