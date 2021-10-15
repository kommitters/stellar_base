defmodule Stellar.XDR.InflationPayoutTest do
  use ExUnit.Case

  import Stellar.Test.Utils

  alias Stellar.XDR.{InflationPayout, Int64}

  describe "InflationPayout Operation" do
    setup do
      destination = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
      amount = Int64.new(1_000_000)

      %{
        destination: destination,
        amount: amount,
        inflation_payout: InflationPayout.new(destination, amount),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 15, 66, 64>>
      }
    end

    test "new/1", %{destination: destination, amount: amount} do
      %InflationPayout{destination: ^destination, amount: ^amount} =
        InflationPayout.new(destination, amount)
    end

    test "encode_xdr/1", %{inflation_payout: inflation_payout, binary: binary} do
      {:ok, ^binary} = InflationPayout.encode_xdr(inflation_payout)
    end

    test "encode_xdr!/1", %{inflation_payout: inflation_payout, binary: binary} do
      ^binary = InflationPayout.encode_xdr!(inflation_payout)
    end

    test "decode_xdr/2", %{inflation_payout: inflation_payout, binary: binary} do
      {:ok, {^inflation_payout, ""}} = InflationPayout.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InflationPayout.decode_xdr(123)
    end

    test "decode_xdr!/2", %{inflation_payout: inflation_payout, binary: binary} do
      {^inflation_payout, ^binary} = InflationPayout.decode_xdr!(binary <> binary)
    end
  end
end
