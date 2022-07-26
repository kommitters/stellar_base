defmodule StellarBase.XDR.ClaimableBalanceFlagsTest do
  use ExUnit.Case

  alias StellarBase.XDR.ClaimableBalanceFlags

  describe "ClaimableBalanceFlags" do
    setup do
      %{
        identifier: :CLAIMABLE_BALANCE_CLAWBACK_ENABLED_FLAG,
        claimable_balance_type:
          ClaimableBalanceFlags.new(:CLAIMABLE_BALANCE_CLAWBACK_ENABLED_FLAG),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1", %{identifier: type} do
      %ClaimableBalanceFlags{identifier: ^type} = ClaimableBalanceFlags.new(type)
    end

    test "new/1 with an invalid type" do
      %ClaimableBalanceFlags{identifier: nil} = ClaimableBalanceFlags.new(nil)
    end

    test "encode_xdr/1", %{claimable_balance_type: claimable_balance_type, binary: binary} do
      {:ok, ^binary} = ClaimableBalanceFlags.encode_xdr(claimable_balance_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        ClaimableBalanceFlags.encode_xdr(%ClaimableBalanceFlags{identifier: :UNDEFINED})
    end

    test "encode_xdr!/1", %{claimable_balance_type: claimable_balance_type, binary: binary} do
      ^binary = ClaimableBalanceFlags.encode_xdr!(claimable_balance_type)
    end

    test "decode_xdr/2", %{claimable_balance_type: claimable_balance_type, binary: binary} do
      {:ok, {^claimable_balance_type, ""}} = ClaimableBalanceFlags.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClaimableBalanceFlags.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{claimable_balance_type: claimable_balance_type, binary: binary} do
      {^claimable_balance_type, ^binary} = ClaimableBalanceFlags.decode_xdr!(binary <> binary)
    end
  end
end
