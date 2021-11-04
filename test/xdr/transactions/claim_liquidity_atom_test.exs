defmodule StellarBase.XDR.ClaimLiquidityAtomTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{ClaimLiquidityAtom, Int64, PoolID}

  describe "ClaimLiquidityAtom" do
    setup do
      pool_id = PoolID.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

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
        pool_id: pool_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought,
        claim_offer_atom:
          ClaimLiquidityAtom.new(
            pool_id,
            asset_sold,
            amount_sold,
            asset_bought,
            amount_bought
          ),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0,
            114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173,
            152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 15, 66,
            64, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 50, 49, 0, 0, 0, 0, 0, 0, 114, 213,
            178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33,
            210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 7, 161, 32>>
      }
    end

    test "new/1", %{
      pool_id: pool_id,
      asset_sold: asset_sold,
      amount_sold: amount_sold,
      asset_bought: asset_bought,
      amount_bought: amount_bought
    } do
      %ClaimLiquidityAtom{
        liquidity_pool_id: ^pool_id,
        asset_sold: ^asset_sold,
        amount_sold: ^amount_sold
      } =
        ClaimLiquidityAtom.new(
          pool_id,
          asset_sold,
          amount_sold,
          asset_bought,
          amount_bought
        )
    end

    test "encode_xdr/1", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      {:ok, ^binary} = ClaimLiquidityAtom.encode_xdr(claim_offer_atom)
    end

    test "encode_xdr!/1", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      ^binary = ClaimLiquidityAtom.encode_xdr!(claim_offer_atom)
    end

    test "decode_xdr/2", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      {:ok, {^claim_offer_atom, ""}} = ClaimLiquidityAtom.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimLiquidityAtom.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claim_offer_atom: claim_offer_atom, binary: binary} do
      {^claim_offer_atom, ^binary} = ClaimLiquidityAtom.decode_xdr!(binary <> binary)
    end
  end
end
