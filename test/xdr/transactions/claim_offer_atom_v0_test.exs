defmodule StellarBase.XDR.ClaimOfferAtomV0Test do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{ClaimOfferAtomV0, Int64}

  describe "ClaimOfferAtomV0" do
    setup do
      seller_ed25519 =
        ed25519_public_key("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

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

      %{
        seller_ed25519: seller_ed25519,
        offer_id: offer_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought,
        claim_offer_atom:
          ClaimOfferAtomV0.new(
            seller_ed25519,
            offer_id,
            asset_sold,
            amount_sold,
            asset_bought,
            amount_bought
          ),
        binary:
          <<155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135,
            171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0, 0, 1,
            226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154,
            137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212,
            179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 15, 66, 64, 0, 0, 0, 2, 66, 84, 67, 78, 69,
            87, 50, 48, 50, 49, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 0, 0, 7, 161, 32>>
      }
    end

    test "new/1", %{
      seller_ed25519: seller_ed25519,
      offer_id: offer_id,
      asset_sold: asset_sold,
      amount_sold: amount_sold,
      asset_bought: asset_bought,
      amount_bought: amount_bought
    } do
      %ClaimOfferAtomV0{
        seller_ed25519: ^seller_ed25519,
        offer_id: ^offer_id,
        asset_sold: ^asset_sold
      } =
        ClaimOfferAtomV0.new(
          seller_ed25519,
          offer_id,
          asset_sold,
          amount_sold,
          asset_bought,
          amount_bought
        )
    end

    test "encode_xdr/1", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      {:ok, ^binary} = ClaimOfferAtomV0.encode_xdr(claim_offer_atom)
    end

    test "encode_xdr!/1", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      ^binary = ClaimOfferAtomV0.encode_xdr!(claim_offer_atom)
    end

    test "decode_xdr/2", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      {:ok, {^claim_offer_atom, ""}} = ClaimOfferAtomV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimOfferAtomV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      {^claim_offer_atom, ^binary} = ClaimOfferAtomV0.decode_xdr!(binary <> binary)
    end
  end
end
