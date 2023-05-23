defmodule StellarBase.XDR.PaymentResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.{PaymentResult, PaymentResultCode}

  describe "PaymentResult" do
    setup do
      code = PaymentResultCode.new(:PAYMENT_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: PaymentResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %PaymentResult{value: ^value, type: ^code} = PaymentResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = PaymentResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = PaymentResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = PaymentResult.new("TEST", code)
      ^binary = PaymentResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = PaymentResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = PaymentResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%PaymentResult{
         value: %Void{value: nil},
         type: %PaymentResultCode{identifier: :PAYMENT_UNDERFUNDED}
       }, ""} = PaymentResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PaymentResult.decode_xdr(123)
    end
  end
end
