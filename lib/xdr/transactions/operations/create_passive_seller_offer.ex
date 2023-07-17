defmodule StellarBase.XDR.CreatePassiveSellOffer do
  @moduledoc """
  Representation of Stellar `CreatePassiveSellOffer` type.
  """
  alias StellarBase.XDR.{Asset, Int64, Price}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(selling: Asset, buying: Asset, amount: Int64, price: Price)

  @type t :: %__MODULE__{
          selling: Asset.t(),
          buying: Asset.t(),
          amount: Int64.t(),
          price: Price.t()
        }

  defstruct [:selling, :buying, :amount, :price]

  @spec new(selling :: Asset.t(), buying :: Asset.t(), amount :: Int64.t(), price :: Price.t()) ::
          t()
  def new(%Asset{} = selling, %Asset{} = buying, %Int64{} = amount, %Price{} = price),
    do: %__MODULE__{selling: selling, buying: buying, amount: amount, price: price}

  @impl true
  def encode_xdr(%__MODULE__{selling: selling, buying: buying, amount: amount, price: price}) do
    [selling: selling, buying: buying, amount: amount, price: price]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{selling: selling, buying: buying, amount: amount, price: price}) do
    [selling: selling, buying: buying, amount: amount, price: price]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [selling: selling, buying: buying, amount: amount, price: price]},
        rest}} ->
        {:ok, {new(selling, buying, amount, price), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [selling: selling, buying: buying, amount: amount, price: price]},
     rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(selling, buying, amount, price), rest}
  end
end
