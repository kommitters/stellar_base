defmodule StellarBase.XDR.Operations.SimplePaymentResultTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.Int64
  alias StellarBase.XDR.Operations.SimplePaymentResult

  describe "SimplePaymentResult" do
    setup do
      destination = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      asset =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount = Int64.new(123_456)

      %{
        destination: destination,
        asset: asset,
        amount: amount,
        payment_result: SimplePaymentResult.new(destination, asset, amount),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 0, 0, 1, 226, 64>>
      }
    end

    test "new/1", %{destination: destination, asset: asset, amount: amount} do
      %SimplePaymentResult{destination: ^destination, asset: ^asset} =
        SimplePaymentResult.new(destination, asset, amount)
    end

    test "encode_xdr/1", %{payment_result: payment_result, binary: binary} do
      {:ok, ^binary} = SimplePaymentResult.encode_xdr(payment_result)
    end

    test "encode_xdr!/1", %{payment_result: payment_result, binary: binary} do
      ^binary = SimplePaymentResult.encode_xdr!(payment_result)
    end

    test "decode_xdr/2", %{payment_result: payment_result, binary: binary} do
      {:ok, {^payment_result, ""}} = SimplePaymentResult.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SimplePaymentResult.decode_xdr(123)
    end

    test "decode_xdr!/2", %{payment_result: payment_result, binary: binary} do
      {^payment_result, ^binary} = SimplePaymentResult.decode_xdr!(binary <> binary)
    end
  end
end
