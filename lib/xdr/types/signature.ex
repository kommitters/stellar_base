defmodule StellarBase.XDR.Signature do
  @moduledoc """
  Representation of Stellar `Signature` type.
  """
  alias StellarBase.XDR.VariableOpaque64

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{signature: String.t()}

  defstruct [:signature]

  @spec new(signature :: String.t()) :: t()
  def new(signature), do: %__MODULE__{signature: signature}

  @impl true
  def encode_xdr(%__MODULE__{signature: signature}) do
    signature
    |> VariableOpaque64.new()
    |> VariableOpaque64.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{signature: signature}) do
    signature
    |> VariableOpaque64.new()
    |> VariableOpaque64.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case VariableOpaque64.decode_xdr(bytes) do
      {:ok, {%VariableOpaque64{opaque: signature}, rest}} -> {:ok, {new(signature), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%VariableOpaque64{opaque: signature}, rest} = VariableOpaque64.decode_xdr!(bytes)
    {new(signature), rest}
  end
end
