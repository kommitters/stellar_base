defmodule StellarBase.XDR.PoolID do
  @moduledoc """
  Representation of Stellar `PoolID` type.
  """
  alias StellarBase.XDR.Hash

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: binary()}

  defstruct [:value]

  @spec new(value :: binary()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    value
    |> Hash.new()
    |> Hash.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    value
    |> Hash.new()
    |> Hash.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Hash.decode_xdr(bytes) do
      {:ok, {%Hash{value: value}, rest}} -> {:ok, {new(value), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Hash{value: value}, rest} = Hash.decode_xdr!(bytes)
    {new(value), rest}
  end
end
