defmodule StellarBase.XDR.ManageOfferSuccessResultTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    ClaimAtom,
    ClaimAtomType,
    ClaimOfferAtom,
    ClaimAtomList,
    OfferEntryExt,
    Int32,
    Int64,
    OfferEntry,
    Price,
    Uint32,
    Void
  }

  alias StellarBase.XDR.{ManageOfferSuccessResultOffer, ManageOfferEffect, ManageOfferSuccessResult}

  describe "ManageOfferSuccessResult" do
    setup do
      asset_sold =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount_sold = Int64.new(123_456)

      offer_id = Int64.new(123_456)

      asset_bought =
        create_asset(:alpha_num12,
          code: "BTCNEW2021",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount_bought = Int64.new(500_000)

      seller_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      claim_offer_atom =
        ClaimOfferAtom.new(
          seller_id,
          offer_id,
          asset_sold,
          amount_sold,
          asset_bought,
          amount_bought
        )

      offers =
        ClaimAtomList.new([
          ClaimAtom.new(claim_offer_atom, ClaimAtomType.new(:CLAIM_ATOM_TYPE_ORDER_BOOK))
        ])

      manage_offer = create_manage_offer()

      %{
        offers: offers,
        manage_offer: manage_offer,
        manage_offer_success: ManageOfferSuccessResult.new(offers, manage_offer),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 0, 0, 1, 226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0,
            114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173,
            152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 1, 226,
            64, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 50, 49, 0, 0, 0, 0, 0, 0, 114, 213,
            178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33,
            210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 7, 161, 32, 0, 0,
            0, 0, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32,
            113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0,
            0, 0, 0, 0, 1, 226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144,
            98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37,
            10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50,
            48, 50, 49, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 0, 0, 76, 75, 64, 0, 0, 0, 1, 0, 0, 0, 10, 0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{offers: offers_claimed, manage_offer: offer} do
      %ManageOfferSuccessResult{offers_claimed: ^offers_claimed, offer: ^offer} =
        ManageOfferSuccessResult.new(offers_claimed, offer)
    end

    test "encode_xdr/1", %{manage_offer_success: manage_offer_success, binary: binary} do
      {:ok, ^binary} = ManageOfferSuccessResult.encode_xdr(manage_offer_success)
    end

    test "encode_xdr!/1", %{manage_offer_success: manage_offer_success, binary: binary} do
      ^binary = ManageOfferSuccessResult.encode_xdr!(manage_offer_success)
    end

    test "decode_xdr/2", %{manage_offer_success: manage_offer_success, binary: binary} do
      {:ok, {^manage_offer_success, ""}} = ManageOfferSuccessResult.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ManageOfferSuccessResult.decode_xdr(123)
    end

    test "decode_xdr!/2", %{manage_offer_success: manage_offer_success, binary: binary} do
      {^manage_offer_success, ^binary} = ManageOfferSuccessResult.decode_xdr!(binary <> binary)
    end
  end

  @spec create_manage_offer() :: ManageOffer.t()
  defp create_manage_offer do
    seller_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
    offer_id = Int64.new(123_456)
    amount = Int64.new(5_000_000)
    price = Price.new(Int32.new(1), Int32.new(10))
    flags = Uint32.new(1)
    ext = OfferEntryExt.new(Void.new(), 0)

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

    seller_id
    |> OfferEntry.new(offer_id, selling, buying, amount, price, flags, ext)
    |> ManageOfferSuccessResultOffer.new(ManageOfferEffect.new(:MANAGE_OFFER_CREATED))
  end
end
