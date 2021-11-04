defmodule StellarBase.XDR.ClaimOfferAtom do
  @moduledoc """
  Representation of Stellar `ClaimOfferAtom` type.
  """

  alias StellarBase.XDR.{AccountID, Asset, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 seller_id: AccountID,
                 offer_id: Int64,
                 asset_sold: Asset,
                 amount_sold: Int64,
                 asset_bought: Asset,
                 amount_bought: Int64
               )

  @type t :: %__MODULE__{
          seller_id: AccountID.t(),
          offer_id: Int64.t(),
          asset_sold: Asset.t(),
          amount_sold: Int64.t(),
          asset_bought: Asset.t(),
          amount_bought: Int64.t()
        }

  defstruct [:seller_id, :offer_id, :asset_sold, :amount_sold, :asset_bought, :amount_bought]

  @spec new(
          seller_id :: AccountID.t(),
          offer_id :: Int64.t(),
          asset_sold :: Asset.t(),
          amount_sold :: Int64.t(),
          asset_bought :: Asset.t(),
          amount_bought :: Int64.t()
        ) :: t()
  def new(
        %AccountID{} = seller_id,
        %Int64{} = offer_id,
        %Asset{} = asset_sold,
        %Int64{} = amount_sold,
        %Asset{} = asset_bought,
        %Int64{} = amount_bought
      ),
      do: %__MODULE__{
        seller_id: seller_id,
        offer_id: offer_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }

  @impl true
  def encode_xdr(%__MODULE__{
        seller_id: seller_id,
        offer_id: offer_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }) do
    [
      seller_id: seller_id,
      offer_id: offer_id,
      asset_sold: asset_sold,
      amount_sold: amount_sold,
      asset_bought: asset_bought,
      amount_bought: amount_bought
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        seller_id: seller_id,
        offer_id: offer_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }) do
    [
      seller_id: seller_id,
      offer_id: offer_id,
      asset_sold: asset_sold,
      amount_sold: amount_sold,
      asset_bought: asset_bought,
      amount_bought: amount_bought
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
            asset_sold: asset_sold,
            amount_sold: amount_sold,
            asset_bought: asset_bought,
            amount_bought: amount_bought
          ]
        }, rest}} ->
        {:ok,
         {new(seller_id, offer_id, asset_sold, amount_sold, asset_bought, amount_bought), rest}}

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
         asset_sold: asset_sold,
         amount_sold: amount_sold,
         asset_bought: asset_bought,
         amount_bought: amount_bought
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(seller_id, offer_id, asset_sold, amount_sold, asset_bought, amount_bought), rest}
  end
end
