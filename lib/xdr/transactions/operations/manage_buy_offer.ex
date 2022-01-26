defmodule StellarBase.XDR.Operations.ManageBuyOffer do
  @moduledoc """
  Representation of Stellar `ManageBuyOffer` type.
  """
  alias StellarBase.XDR.{Asset, Int64, Price}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 selling: Asset,
                 buying: Asset,
                 buy_amount: Int64,
                 price: Price,
                 offer_id: Int64
               )

  @type t :: %__MODULE__{
          selling: Asset.t(),
          buying: Asset.t(),
          buy_amount: Int64.t(),
          price: Price.t(),
          offer_id: Int64.t()
        }

  defstruct [:selling, :buying, :buy_amount, :price, :offer_id]

  @spec new(
          selling :: Asset.t(),
          buying :: Asset.t(),
          buy_amount :: Int64.t(),
          price :: Price.t(),
          offer_id :: Int64.t()
        ) :: t()
  def new(
        %Asset{} = selling,
        %Asset{} = buying,
        %Int64{} = buy_amount,
        %Price{} = price,
        %Int64{} = offer_id
      ),
      do: %__MODULE__{
        selling: selling,
        buying: buying,
        buy_amount: buy_amount,
        price: price,
        offer_id: offer_id
      }

  @impl true
  def encode_xdr(%__MODULE__{
        selling: selling,
        buying: buying,
        buy_amount: buy_amount,
        price: price,
        offer_id: offer_id
      }) do
    [selling: selling, buying: buying, buy_amount: buy_amount, price: price, offer_id: offer_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        selling: selling,
        buying: buying,
        buy_amount: buy_amount,
        price: price,
        offer_id: offer_id
      }) do
    [selling: selling, buying: buying, buy_amount: buy_amount, price: price, offer_id: offer_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            selling: selling,
            buying: buying,
            buy_amount: buy_amount,
            price: price,
            offer_id: offer_id
          ]
        }, rest}} ->
        {:ok, {new(selling, buying, buy_amount, price, offer_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         selling: selling,
         buying: buying,
         buy_amount: buy_amount,
         price: price,
         offer_id: offer_id
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(selling, buying, buy_amount, price, offer_id), rest}
  end
end
