defmodule StellarBase.XDR.String30 do
  @moduledoc """
  Representation of Stellar `String30` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: String.t()}

  defstruct [:value]

  @max_length 30

  @spec new(value :: String.t()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    value
    |> XDR.String.new(@max_length)
    |> XDR.String.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    value
    |> XDR.String.new(@max_length)
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
