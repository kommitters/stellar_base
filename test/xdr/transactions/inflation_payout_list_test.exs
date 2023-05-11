defmodule StellarBase.XDR.InflationPayoutListTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{InflationPayout, InflationPayoutList, Int64}

  describe "InflationPayoutList" do
    setup do
      destination1 = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
      destination2 = create_account_id("GCZJWODSGHQRWUB4K4TGXL7RM7WIRNXQIEOYBFWF54XB3WIVOMWLIMKK")
      payout1 = InflationPayout.new(destination1, Int64.new(1_000_000))
      payout2 = InflationPayout.new(destination2, Int64.new(5_000_000))
      payouts = [payout1, payout2]

      %{
        payouts: payouts,
        inflation_payout_list: InflationPayoutList.new(payouts),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 15, 66, 64, 0, 0, 0, 0, 178, 155, 56, 114, 49, 225, 27, 80, 60,
            87, 38, 107, 175, 241, 103, 236, 136, 182, 240, 65, 29, 128, 150, 197, 239, 46, 29,
            217, 21, 115, 44, 180, 0, 0, 0, 0, 0, 76, 75, 64>>
      }
    end

    test "new/1", %{payouts: payouts} do
      %InflationPayoutList{items: ^payouts} = InflationPayoutList.new(payouts)
    end

    test "encode_xdr/1", %{inflation_payout_list: inflation_payout_list, binary: binary} do
      {:ok, ^binary} = InflationPayoutList.encode_xdr(inflation_payout_list)
    end

    test "encode_xdr!/1", %{inflation_payout_list: inflation_payout_list, binary: binary} do
      ^binary = InflationPayoutList.encode_xdr!(inflation_payout_list)
    end

    test "decode_xdr/2", %{inflation_payout_list: inflation_payout_list, binary: binary} do
      {:ok, {^inflation_payout_list, ""}} = InflationPayoutList.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InflationPayoutList.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{inflation_payout_list: inflation_payout_list, binary: binary} do
      {^inflation_payout_list, ^binary} = InflationPayoutList.decode_xdr!(binary <> binary)
    end
  end
end
