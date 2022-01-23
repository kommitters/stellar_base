defmodule StellarBase.XDR.Operations.ManageSellOfferResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.ManageSellOfferResultCode

  @codes [
    :MANAGE_SELL_OFFER_SUCCESS,
    :MANAGE_SELL_OFFER_MALFORMED,
    :MANAGE_SELL_OFFER_SELL_NO_TRUST,
    :MANAGE_SELL_OFFER_BUY_NO_TRUST,
    :MANAGE_SELL_OFFER_SELL_NOT_AUTHORIZED,
    :MANAGE_SELL_OFFER_BUY_NOT_AUTHORIZED,
    :MANAGE_SELL_OFFER_LINE_FULL,
    :MANAGE_SELL_OFFER_UNDERFUNDED,
    :MANAGE_SELL_OFFER_CROSS_SELF,
    :MANAGE_SELL_OFFER_SELL_NO_ISSUER,
    :MANAGE_SELL_OFFER_BUY_NO_ISSUER,
    :MANAGE_SELL_OFFER_NOT_FOUND,
    :MANAGE_SELL_OFFER_LOW_RESERVE
  ]

  describe "ManageSellOfferResultCode" do
    setup do
      %{
        codes: @codes,
        result: ManageSellOfferResultCode.new(:MANAGE_SELL_OFFER_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ManageSellOfferResultCode{identifier: ^type} = ManageSellOfferResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ManageSellOfferResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ManageSellOfferResultCode.encode_xdr(%ManageSellOfferResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ManageSellOfferResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ManageSellOfferResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ManageSellOfferResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ManageSellOfferResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%ManageSellOfferResultCode{identifier: :MANAGE_SELL_OFFER_SELL_NOT_AUTHORIZED}, ""} =
        ManageSellOfferResultCode.decode_xdr!(<<255, 255, 255, 252>>)
    end
  end
end
