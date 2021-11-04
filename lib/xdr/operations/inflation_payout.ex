defmodule StellarBase.XDR.InflationPayout do
  @moduledoc """
  Representation of Stellar `InflationPayout` type.
  """
  alias StellarBase.XDR.{AccountID, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(destination: AccountID, amount: Int64)

  @type t :: %__MODULE__{destination: AccountID.t(), amount: Int64.t()}

  defstruct [:destination, :amount, :authorize]

  @spec new(destination :: AccountID.t(), amount :: Int64.t()) :: t()
  def new(%AccountID{} = destination, %Int64{} = amount),
    do: %__MODULE__{destination: destination, amount: amount}

  @impl true
  def encode_xdr(%__MODULE__{destination: destination, amount: amount}) do
    [destination: destination, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{destination: destination, amount: amount}) do
    [destination: destination, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [destination: destination, amount: amount]}, rest}} ->
        {:ok, {new(destination, amount), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [destination: destination, amount: amount]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(destination, amount), rest}
  end
end
