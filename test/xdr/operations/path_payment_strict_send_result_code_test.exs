defmodule StellarBase.XDR.Operations.PathPaymentStrictSendResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.PathPaymentStrictSendResultCode

  @codes [
    :PATH_PAYMENT_STRICT_SEND_SUCCESS,
    :PATH_PAYMENT_STRICT_SEND_MALFORMED,
    :PATH_PAYMENT_STRICT_SEND_UNDERFUNDED,
    :PATH_PAYMENT_STRICT_SEND_SRC_NO_TRUST,
    :PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED,
    :PATH_PAYMENT_STRICT_SEND_NO_DESTINATION,
    :PATH_PAYMENT_STRICT_SEND_NO_TRUST,
    :PATH_PAYMENT_STRICT_SEND_NOT_AUTHORIZED,
    :PATH_PAYMENT_STRICT_SEND_LINE_FULL,
    :PATH_PAYMENT_STRICT_SEND_NO_ISSUER,
    :PATH_PAYMENT_STRICT_SEND_TOO_FEW_OFFERS,
    :PATH_PAYMENT_STRICT_SEND_OFFER_CROSS_SELF,
    :PATH_PAYMENT_STRICT_SEND_UNDER_DESTMIN
  ]

  describe "PathPaymentStrictSendResultCode" do
    setup do
      %{
        codes: @codes,
        result: PathPaymentStrictSendResultCode.new(:PATH_PAYMENT_STRICT_SEND_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %PathPaymentStrictSendResultCode{identifier: ^type} =
              PathPaymentStrictSendResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = PathPaymentStrictSendResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        PathPaymentStrictSendResultCode.encode_xdr(%PathPaymentStrictSendResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = PathPaymentStrictSendResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = PathPaymentStrictSendResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = PathPaymentStrictSendResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = PathPaymentStrictSendResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%PathPaymentStrictSendResultCode{
         identifier: :PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED
       }, ""} = PathPaymentStrictSendResultCode.decode_xdr!(<<255, 255, 255, 252>>)
    end
  end
end
