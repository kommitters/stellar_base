defmodule StellarBase.XDR.LedgerKeyClaimableBalanceTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ClaimableBalanceID, ClaimableBalanceIDType, Hash}
  alias StellarBase.XDR.LedgerKeyClaimableBalance

  describe "Ledger LedgerKeyClaimableBalance" do
    setup do
      balance_id_type = ClaimableBalanceIDType.new(:CLAIMABLE_BALANCE_ID_TYPE_V0)
      balance_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      balance_id = ClaimableBalanceID.new(balance_id, balance_id_type)

      %{
        balance_id: balance_id,
        claimable_balance: LedgerKeyClaimableBalance.new(balance_id),
        binary:
          <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{balance_id: balance_id} do
      %LedgerKeyClaimableBalance{balance_id: ^balance_id} =
        LedgerKeyClaimableBalance.new(balance_id)
    end

    test "encode_xdr/1", %{claimable_balance: claimable_balance, binary: binary} do
      {:ok, ^binary} = LedgerKeyClaimableBalance.encode_xdr(claimable_balance)
    end

    test "encode_xdr!/1", %{claimable_balance: claimable_balance, binary: binary} do
      ^binary = LedgerKeyClaimableBalance.encode_xdr!(claimable_balance)
    end

    test "decode_xdr/2", %{claimable_balance: claimable_balance, binary: binary} do
      {:ok, {^claimable_balance, ""}} = LedgerKeyClaimableBalance.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyClaimableBalance.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claimable_balance: claimable_balance, binary: binary} do
      {^claimable_balance, ^binary} = LedgerKeyClaimableBalance.decode_xdr!(binary <> binary)
    end
  end
end
