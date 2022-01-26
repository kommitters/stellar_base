defmodule StellarBase.XDR.Operations.PathPaymentStrictReceiveResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.PathPaymentStrictReceiveResultCode

  @codes [
    :PATH_PAYMENT_STRICT_RECEIVE_SUCCESS,
    :PATH_PAYMENT_STRICT_RECEIVE_MALFORMED,
    :PATH_PAYMENT_STRICT_RECEIVE_UNDERFUNDED,
    :PATH_PAYMENT_STRICT_RECEIVE_SRC_NO_TRUST,
    :PATH_PAYMENT_STRICT_RECEIVE_SRC_NOT_AUTHORIZED,
    :PATH_PAYMENT_STRICT_RECEIVE_NO_DESTINATION,
    :PATH_PAYMENT_STRICT_RECEIVE_NO_TRUST,
    :PATH_PAYMENT_STRICT_RECEIVE_NOT_AUTHORIZED,
    :PATH_PAYMENT_STRICT_RECEIVE_LINE_FULL,
    :PATH_PAYMENT_STRICT_RECEIVE_NO_ISSUER,
    :PATH_PAYMENT_STRICT_RECEIVE_TOO_FEW_OFFERS,
    :PATH_PAYMENT_STRICT_RECEIVE_OFFER_CROSS_SELF,
    :PATH_PAYMENT_STRICT_RECEIVE_OVER_SENDMAX
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
    <<255, 255, 255, 247>>,
    <<255, 255, 255, 246>>,
    <<255, 255, 255, 245>>,
    <<255, 255, 255, 244>>
  ]

  describe "PathPaymentStrictReceiveResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> PathPaymentStrictReceiveResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %PathPaymentStrictReceiveResultCode{identifier: ^type} =
              PathPaymentStrictReceiveResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = PathPaymentStrictReceiveResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        PathPaymentStrictReceiveResultCode.encode_xdr(%PathPaymentStrictReceiveResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = PathPaymentStrictReceiveResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = PathPaymentStrictReceiveResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = PathPaymentStrictReceiveResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do:
            {^result, ^binary} = PathPaymentStrictReceiveResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%PathPaymentStrictReceiveResultCode{
               identifier: _
             }, ""} = PathPaymentStrictReceiveResultCode.decode_xdr!(binary)
    end
  end
end
