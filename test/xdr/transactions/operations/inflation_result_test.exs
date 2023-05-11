defmodule StellarBase.XDR.InflationResultTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{InflationPayout, InflationPayoutList, Int64}
  alias StellarBase.XDR.{InflationResult, InflationResultCode}

  describe "InflationResult" do
    setup do
      destination1 = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
      destination2 = create_account_id("GCZJWODSGHQRWUB4K4TGXL7RM7WIRNXQIEOYBFWF54XB3WIVOMWLIMKK")

      payout1 = InflationPayout.new(destination1, Int64.new(1_000_000))
      payout2 = InflationPayout.new(destination2, Int64.new(5_000_000))
      payouts = [payout1, payout2]

      code = InflationResultCode.new(:INFLATION_SUCCESS)
      value = InflationPayoutList.new(payouts)

      %{
        code: code,
        value: value,
        result: InflationResult.new(value, code),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 0, 0, 15, 66, 64, 0, 0, 0, 0, 178, 155, 56, 114, 49, 225,
            27, 80, 60, 87, 38, 107, 175, 241, 103, 236, 136, 182, 240, 65, 29, 128, 150, 197,
            239, 46, 29, 217, 21, 115, 44, 180, 0, 0, 0, 0, 0, 76, 75, 64>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %InflationResult{value: ^code, type: ^value} = InflationResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = InflationResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = InflationResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value" do
      code = InflationResultCode.new(:INFLATION_NOT_TIME)

      <<255, 255, 255, 255>> =
        "TEST"
        |> InflationResult.new(code)
        |> InflationResult.encode_xdr!()
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = InflationResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = InflationResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%InflationResult{
         value: %InflationResultCode{identifier: :INFLATION_NOT_TIME}
       }, ""} = InflationResult.decode_xdr!(<<255, 255, 255, 255>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InflationResult.decode_xdr(123)
    end
  end
end
