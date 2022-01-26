defmodule StellarBase.XDR.Operations.SimplePaymentResult do
  @moduledoc """
  Representation of Stellar `SimplePaymentResult` type.
  """
  alias StellarBase.XDR.{AccountID, Asset, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(destination: AccountID, asset: Asset, amount: Int64)

  @type t :: %__MODULE__{destination: AccountID.t(), asset: Asset.t(), amount: Int64.t()}

  defstruct [:destination, :asset, :amount]

  @spec new(destination :: AccountID.t(), asset :: Asset.t(), amount :: Int64.t()) :: t()
  def new(%AccountID{} = destination, %Asset{} = asset, %Int64{} = amount),
    do: %__MODULE__{destination: destination, asset: asset, amount: amount}

  @impl true
  def encode_xdr(%__MODULE__{destination: destination, asset: asset, amount: amount}) do
    [destination: destination, asset: asset, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{destination: destination, asset: asset, amount: amount}) do
    [destination: destination, asset: asset, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [destination: destination, asset: asset, amount: amount]}, rest}} ->
        {:ok, {new(destination, asset, amount), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [destination: destination, asset: asset, amount: amount]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(destination, asset, amount), rest}
  end
end
