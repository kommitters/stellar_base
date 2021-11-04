defmodule StellarBase.XDR.Ledger.OfferTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, Int64, PublicKey, PublicKeyType, UInt256}
  alias StellarBase.XDR.Ledger.Offer

  describe "Ledger Offer" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      seller_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StellarBase.Ed25519.PublicKey.decode!()
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      offer_id = Int64.new(123_456)

      %{
        seller_id: seller_id,
        offer_id: offer_id,
        offer: Offer.new(seller_id, offer_id),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0,
            0, 0, 1, 226, 64>>
      }
    end

    test "new/1", %{seller_id: seller_id, offer_id: offer_id} do
      %Offer{seller_id: ^seller_id, offer_id: ^offer_id} = Offer.new(seller_id, offer_id)
    end

    test "encode_xdr/1", %{offer: offer, binary: binary} do
      {:ok, ^binary} = Offer.encode_xdr(offer)
    end

    test "encode_xdr!/1", %{offer: offer, binary: binary} do
      ^binary = Offer.encode_xdr!(offer)
    end

    test "decode_xdr/2", %{offer: offer, binary: binary} do
      {:ok, {^offer, ""}} = Offer.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Offer.decode_xdr(123)
    end

    test "decode_xdr!/2", %{offer: offer, binary: binary} do
      {^offer, ^binary} = Offer.decode_xdr!(binary <> binary)
    end
  end
end
