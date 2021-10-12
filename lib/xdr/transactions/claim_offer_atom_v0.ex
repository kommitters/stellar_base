defmodule Stellar.XDR.ClaimOfferAtomV0 do
  @moduledoc """
  Representation of Stellar `ClaimOfferAtomV0` type.

  ClaimOfferAtomV0 is a ClaimOfferAtom with the AccountID discriminant stripped
  off, leaving a raw ed25519 public key to identify the source account. This is
  used for backwards compatibility starting from the protocol 17/18 boundary.
  If an "old-style" ClaimOfferAtom is parsed with this XDR definition, it will
  be parsed as a "new-style" ClaimAtom containing a ClaimOfferAtomV0.
  """

  alias Stellar.XDR.{Asset, Int64, UInt256}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 seller_ed25519: UInt256,
                 offer_id: Int64,
                 asset_sold: Asset,
                 amount_sold: Int64,
                 asset_bought: Asset,
                 amount_bought: Int64
               )

  @type t :: %__MODULE__{
          seller_ed25519: UInt256.t(),
          offer_id: Int64.t(),
          asset_sold: Asset.t(),
          amount_sold: Int64.t(),
          asset_bought: Asset.t(),
          amount_bought: Int64.t()
        }

  defstruct [:seller_ed25519, :offer_id, :asset_sold, :amount_sold, :asset_bought, :amount_bought]

  @spec new(
          seller_ed25519 :: UInt256.t(),
          offer_id :: Int64.t(),
          asset_sold :: Asset.t(),
          amount_sold :: Int64.t(),
          asset_bought :: Asset.t(),
          amount_bought :: Int64.t()
        ) :: t()
  def new(
        %UInt256{} = seller_ed25519,
        %Int64{} = offer_id,
        %Asset{} = asset_sold,
        %Int64{} = amount_sold,
        %Asset{} = asset_bought,
        %Int64{} = amount_bought
      ),
      do: %__MODULE__{
        seller_ed25519: seller_ed25519,
        offer_id: offer_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }

  @impl true
  def encode_xdr(%__MODULE__{
        seller_ed25519: seller_ed25519,
        offer_id: offer_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }) do
    [
      seller_ed25519: seller_ed25519,
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
        seller_ed25519: seller_ed25519,
        offer_id: offer_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }) do
    [
      seller_ed25519: seller_ed25519,
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
            seller_ed25519: seller_ed25519,
            offer_id: offer_id,
            asset_sold: asset_sold,
            amount_sold: amount_sold,
            asset_bought: asset_bought,
            amount_bought: amount_bought
          ]
        }, rest}} ->
        {:ok,
         {new(seller_ed25519, offer_id, asset_sold, amount_sold, asset_bought, amount_bought),
          rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         seller_ed25519: seller_ed25519,
         offer_id: offer_id,
         asset_sold: asset_sold,
         amount_sold: amount_sold,
         asset_bought: asset_bought,
         amount_bought: amount_bought
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(seller_ed25519, offer_id, asset_sold, amount_sold, asset_bought, amount_bought), rest}
  end
end
