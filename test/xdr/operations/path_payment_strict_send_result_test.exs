defmodule Stellar.XDR.Operations.PathPaymentStrictSendResultTest do
  use ExUnit.Case

  import Stellar.Test.Utils

  alias Stellar.XDR.{
    ClaimAtom,
    ClaimAtomType,
    ClaimOfferAtom,
    ClaimAtomList,
    Int64
  }

  alias Stellar.XDR.Operations.{
    PathPaymentStrictSendResult,
    PathPaymentStrictSendResultCode,
    PathPaymentStrictResultSuccess,
    SimplePaymentResult
  }

  describe "PathPaymentStrictSendResult" do
    setup do
      destination = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      asset_sold =
        create_asset(:alpha_num4,
          code: "BTCN",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount_sold = Int64.new(123_456)

      offer_id = Int64.new(123_456)

      asset_bought =
        create_asset(:alpha_num12,
          code: "BTCNEW2021",
          issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        )

      amount_bought = Int64.new(500_000)

      seller_id = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      claim_offer_atom =
        ClaimOfferAtom.new(
          seller_id,
          offer_id,
          asset_sold,
          amount_sold,
          asset_bought,
          amount_bought
        )

      offers =
        ClaimAtomList.new([
          ClaimAtom.new(claim_offer_atom, ClaimAtomType.new(:CLAIM_ATOM_TYPE_ORDER_BOOK))
        ])

      last_payment = SimplePaymentResult.new(destination, asset_sold, amount_sold)

      code = PathPaymentStrictSendResultCode.new(:PATH_PAYMENT_STRICT_SEND_SUCCESS)

      path_payment_success = PathPaymentStrictResultSuccess.new(offers, last_payment)

      %{
        code: code,
        value: path_payment_success,
        result: PathPaymentStrictSendResult.new(path_payment_success, code),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29,
            207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165,
            56, 34, 114, 247, 89, 216, 0, 0, 0, 0, 0, 1, 226, 64, 0, 0, 0, 1, 66, 84, 67, 78, 0,
            0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221,
            187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0,
            1, 226, 64, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 50, 49, 0, 0, 0, 0, 0, 0, 114,
            213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152,
            33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 7, 161, 32, 0,
            0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 0, 0, 1, 226, 64>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %PathPaymentStrictSendResult{code: ^code, result: ^value} =
        PathPaymentStrictSendResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = PathPaymentStrictSendResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = PathPaymentStrictSendResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value" do
      code = PathPaymentStrictSendResultCode.new(:PATH_PAYMENT_STRICT_SEND_LINE_FULL)
      result = PathPaymentStrictSendResult.new("TEST", code)

      <<255, 255, 255, 248>> = PathPaymentStrictSendResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = PathPaymentStrictSendResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = PathPaymentStrictSendResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%PathPaymentStrictSendResult{
         code: %PathPaymentStrictSendResultCode{
           identifier: :PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED
         }
       }, ""} = PathPaymentStrictSendResult.decode_xdr!(<<255, 255, 255, 252>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PathPaymentStrictSendResult.decode_xdr(123)
    end
  end
end
