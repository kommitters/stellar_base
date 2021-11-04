defmodule StellarBase.XDR.Operations.PaymentResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.PaymentResultCode

  describe "PaymentResultCode" do
    setup do
      %{
        code: :PAYMENT_SUCCESS,
        result: PaymentResultCode.new(:PAYMENT_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %PaymentResultCode{identifier: ^type} = PaymentResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = PaymentResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} = PaymentResultCode.encode_xdr(%PaymentResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = PaymentResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = PaymentResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = PaymentResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = PaymentResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%PaymentResultCode{identifier: :PAYMENT_MALFORMED}, ""} =
        PaymentResultCode.decode_xdr!(<<255, 255, 255, 255>>)
    end
  end
end
