defmodule StellarBase.XDR.ClaimAtomListTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    ClaimAtom,
    ClaimAtomType,
    ClaimOfferAtom,
    ClaimAtomList,
    Int64
  }

  describe "ClaimAtomList" do
    setup do
      offer_id = Int64.new(123_456)

      asset_sold =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount_sold = Int64.new(1_000_000)

      asset_bought =
        create_asset(:alpha_num12,
          code: "BTCNEW2021",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount_bought = Int64.new(500_000)

      claim_atom_type = ClaimAtomType.new(:CLAIM_ATOM_TYPE_ORDER_BOOK)

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

      offers = [ClaimAtom.new(claim_offer_atom, claim_atom_type)]

      %{
        offers: offers,
        claim_atom_list: ClaimAtomList.new(offers),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 0, 0, 1, 226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0,
            114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173,
            152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 15, 66,
            64, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 50, 49, 0, 0, 0, 0, 0, 0, 114, 213,
            178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33,
            210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 7, 161, 32>>
      }
    end

    test "new/1", %{offers: offers} do
      %ClaimAtomList{offers: ^offers} = ClaimAtomList.new(offers)
    end

    test "encode_xdr/1", %{claim_atom_list: claim_atom_list, binary: binary} do
      {:ok, ^binary} = ClaimAtomList.encode_xdr(claim_atom_list)
    end

    test "encode_xdr!/1", %{claim_atom_list: claim_atom_list, binary: binary} do
      ^binary = ClaimAtomList.encode_xdr!(claim_atom_list)
    end

    test "decode_xdr/2", %{claim_atom_list: claim_atom_list, binary: binary} do
      {:ok, {^claim_atom_list, ""}} = ClaimAtomList.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimAtomList.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{claim_atom_list: claim_atom_list, binary: binary} do
      {^claim_atom_list, ^binary} = ClaimAtomList.decode_xdr!(binary <> binary)
    end
  end
end
