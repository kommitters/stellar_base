defmodule StellarBase.XDR.ClaimClaimableBalanceOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ClaimableBalanceID, ClaimableBalanceIDType, Hash}
  alias StellarBase.XDR.ClaimClaimableBalanceOp

  describe "ClaimClaimableBalanceOp Operation" do
    setup do
      balance_id_type = ClaimableBalanceIDType.new(:CLAIMABLE_BALANCE_ID_TYPE_V0)
      balance_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      claimable_balance_id = ClaimableBalanceID.new(balance_id, balance_id_type)

      %{
        claimable_balance_id: claimable_balance_id,
        claim_claimable_balance: ClaimClaimableBalanceOp.new(claimable_balance_id),
        binary:
          <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{claimable_balance_id: claimable_balance_id} do
      %ClaimClaimableBalanceOp{balance_id: ^claimable_balance_id} =
        ClaimClaimableBalanceOp.new(claimable_balance_id)
    end

    test "encode_xdr/1", %{claim_claimable_balance: claim_claimable_balance, binary: binary} do
      {:ok, ^binary} = ClaimClaimableBalanceOp.encode_xdr(claim_claimable_balance)
    end

    test "encode_xdr!/1", %{claim_claimable_balance: claim_claimable_balance, binary: binary} do
      ^binary = ClaimClaimableBalanceOp.encode_xdr!(claim_claimable_balance)
    end

    test "decode_xdr/2", %{claim_claimable_balance: claim_claimable_balance, binary: binary} do
      {:ok, {^claim_claimable_balance, ""}} = ClaimClaimableBalanceOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimClaimableBalanceOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claim_claimable_balance: claim_claimable_balance, binary: binary} do
      {^claim_claimable_balance, ^binary} = ClaimClaimableBalanceOp.decode_xdr!(binary <> binary)
    end
  end
end
