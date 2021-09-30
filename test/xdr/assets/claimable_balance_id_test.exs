defmodule Stellar.XDR.ClaimableBalanceIDTest do
  use ExUnit.Case

  alias Stellar.XDR.{ClaimableBalanceID, ClaimableBalanceIDType, Hash}

  describe "ClaimableBalanceID" do
    setup do
      balance_id_type = ClaimableBalanceIDType.new(:CLAIMABLE_BALANCE_ID_TYPE_V0)
      balance_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        balance_id_type: balance_id_type,
        balance_id: balance_id,
        claimable_balance_id: ClaimableBalanceID.new(balance_id, balance_id_type),
        binary:
          <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{balance_id: balance_id, balance_id_type: balance_id_type} do
      %ClaimableBalanceID{claimable_balance_id: ^balance_id, type: ^balance_id_type} =
        ClaimableBalanceID.new(balance_id, balance_id_type)
    end

    test "encode_xdr/1", %{claimable_balance_id: claimable_balance_id, binary: binary} do
      {:ok, ^binary} = ClaimableBalanceID.encode_xdr(claimable_balance_id)
    end

    test "encode_xdr/1 with an invalid type", %{claimable_balance_id: claimable_balance_id} do
      balance_id_type = ClaimableBalanceIDType.new(:NEW_BITCOIN)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     claimable_balance_id
                     |> ClaimableBalanceID.new(balance_id_type)
                     |> ClaimableBalanceID.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{claimable_balance_id: claimable_balance_id, binary: binary} do
      ^binary = ClaimableBalanceID.encode_xdr!(claimable_balance_id)
    end

    test "decode_xdr/2", %{claimable_balance_id: claimable_balance_id, binary: binary} do
      {:ok, {^claimable_balance_id, ""}} = ClaimableBalanceID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimableBalanceID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claimable_balance_id: claimable_balance_id, binary: binary} do
      {^claimable_balance_id, ^binary} = ClaimableBalanceID.decode_xdr!(binary <> binary)
    end
  end
end
