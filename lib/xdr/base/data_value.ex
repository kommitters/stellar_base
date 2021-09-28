defmodule Stellar.XDR.DataValue do
  @moduledoc """
  Representation of Stellar `DataValue` type.
  """
  alias Stellar.XDR.VariableOpaque64

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: binary()}

  defstruct [:value]

  @spec new(value :: binary()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    value
    |> VariableOpaque64.new()
    |> VariableOpaque64.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    value
    |> VariableOpaque64.new()
    |> VariableOpaque64.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case VariableOpaque64.decode_xdr(bytes) do
      {:ok, {%VariableOpaque64{opaque: value}, rest}} -> {:ok, {new(value), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%VariableOpaque64{opaque: value}, rest} = VariableOpaque64.decode_xdr!(bytes)
    {new(value), rest}
  end
end
