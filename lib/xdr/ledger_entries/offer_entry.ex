defmodule StellarBase.XDR.OfferEntry do
  @moduledoc """
  Representation of Stellar `OfferEntry` type.

  An offer is the building block of the offer book, they are automatically
  claimed by payments when the price set by the owner is met.

  For example an Offer is selling 10A where 1A is priced at 1.5B
  """
  alias StellarBase.XDR.{AccountID, Asset, Int64, Price}
  alias StellarBase.XDR.Ext

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 seller_id: AccountID,
                 offer_id: Int64,
                 selling: Asset,
                 buying: Asset,
                 amount: Int64,
                 price: Price,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          seller_id: AccountID.t(),
          offer_id: Int64.t(),
          selling: Asset.t(),
          buying: Asset.t(),
          amount: Int64.t(),
          price: Price.t(),
          ext: Ext.t()
        }

  defstruct [:seller_id, :offer_id, :selling, :buying, :amount, :price, :ext]

  @spec new(
          seller_id :: AccountID.t(),
          offer_id :: Int64.t(),
          selling :: Asset.t(),
          buying :: Asset.t(),
          amount :: Int64.t(),
          price :: Price.t(),
          ext :: Ext.t()
        ) ::
          t()
  def new(
        %AccountID{} = seller_id,
        %Int64{} = offer_id,
        %Asset{} = selling,
        %Asset{} = buying,
        %Int64{} = amount,
        %Price{} = price,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        seller_id: seller_id,
        offer_id: offer_id,
        selling: selling,
        buying: buying,
        amount: amount,
        price: price,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        seller_id: seller_id,
        offer_id: offer_id,
        selling: selling,
        buying: buying,
        amount: amount,
        price: price,
        ext: ext
      }) do
    [
      seller_id: seller_id,
      offer_id: offer_id,
      selling: selling,
      buying: buying,
      amount: amount,
      price: price,
      ext: ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        seller_id: seller_id,
        offer_id: offer_id,
        selling: selling,
        buying: buying,
        amount: amount,
        price: price,
        ext: ext
      }) do
    [
      seller_id: seller_id,
      offer_id: offer_id,
      selling: selling,
      buying: buying,
      amount: amount,
      price: price,
      ext: ext
    ]
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
            seller_id: seller_id,
            offer_id: offer_id,
            selling: selling,
            buying: buying,
            amount: amount,
            price: price,
            ext: ext
          ]
        }, rest}} ->
        {:ok, {new(seller_id, offer_id, selling, buying, amount, price, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         seller_id: seller_id,
         offer_id: offer_id,
         selling: selling,
         buying: buying,
         amount: amount,
         price: price,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(seller_id, offer_id, selling, buying, amount, price, ext), rest}
  end
end
