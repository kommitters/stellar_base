defmodule StellarBase.XDR.Operations.ManageOfferTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{Ext, Int32, Int64, OfferEntry, Price, UInt32}
  alias StellarBase.XDR.Operations.{ManageOffer, ManageOfferEffect}

  describe "ManageOffer" do
    setup do
      seller_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      offer_id = Int64.new(123_456)

      selling =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      buying =
        create_asset(:alpha_num12,
          code: "BTCNEW2021",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount = Int64.new(5_000_000)

      price = Price.new(Int32.new(1), Int32.new(10))

      flags = UInt32.new(1)

      ext = Ext.new()

      effect = ManageOfferEffect.new(:MANAGE_OFFER_CREATED)

      offer = OfferEntry.new(seller_id, offer_id, selling, buying, amount, price, flags, ext)

      %{
        effect: effect,
        offer: offer,
        manage_offer: ManageOffer.new(offer, effect),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 1, 226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178,
            144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210,
            37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87,
            50, 48, 50, 49, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149,
            154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2,
            227, 119, 0, 0, 0, 0, 0, 76, 75, 64, 0, 0, 0, 1, 0, 0, 0, 10, 0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{offer: offer, effect: effect} do
      %ManageOffer{offer: ^offer, effect: ^effect} = ManageOffer.new(offer, effect)
    end

    test "encode_xdr/1", %{manage_offer: manage_offer, binary: binary} do
      {:ok, ^binary} = ManageOffer.encode_xdr(manage_offer)
    end

    test "encode_xdr!/1", %{manage_offer: manage_offer, binary: binary} do
      ^binary = ManageOffer.encode_xdr!(manage_offer)
    end

    test "decode_xdr/2", %{manage_offer: manage_offer, binary: binary} do
      {:ok, {^manage_offer, ""}} = ManageOffer.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{manage_offer: manage_offer, binary: binary} do
      {^manage_offer, ^binary} = ManageOffer.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ManageOffer.decode_xdr(123)
    end
  end
end
