defmodule StellarBase.XDR.SCBytes do
  @moduledoc """
  Representation of Stellar `SCBytes` type.
  """
  alias StellarBase.XDR.VariableOpaque256000

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: binary()}

  defstruct [:value]

  @spec new(value :: binary()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    value
    |> VariableOpaque256000.new()
    |> VariableOpaque256000.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    value
    |> VariableOpaque256000.new()
    |> VariableOpaque256000.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case VariableOpaque256000.decode_xdr(bytes) do
      {:ok, {%VariableOpaque256000{opaque: value}, rest}} -> {:ok, {new(value), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%VariableOpaque256000{opaque: value}, rest} = VariableOpaque256000.decode_xdr!(bytes)
    {new(value), rest}
  end
end
