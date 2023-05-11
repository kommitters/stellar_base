defmodule StellarBase.XDR.PaymentResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.PaymentResultCode

  @codes [
    :PAYMENT_SUCCESS,
    :PAYMENT_MALFORMED,
    :PAYMENT_UNDERFUNDED,
    :PAYMENT_SRC_NO_TRUST,
    :PAYMENT_SRC_NOT_AUTHORIZED,
    :PAYMENT_NO_DESTINATION,
    :PAYMENT_NO_TRUST,
    :PAYMENT_NOT_AUTHORIZED,
    :PAYMENT_LINE_FULL,
    :PAYMENT_NO_ISSUER
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>,
    <<255, 255, 255, 250>>,
    <<255, 255, 255, 249>>,
    <<255, 255, 255, 248>>,
    <<255, 255, 255, 247>>
  ]

  describe "PaymentResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> PaymentResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types, do: %PaymentResultCode{identifier: ^type} = PaymentResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = PaymentResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} = PaymentResultCode.encode_xdr(%PaymentResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = PaymentResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = PaymentResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = PaymentResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = PaymentResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%PaymentResultCode{identifier: _}, ""} = PaymentResultCode.decode_xdr!(binary)
    end
  end
end
