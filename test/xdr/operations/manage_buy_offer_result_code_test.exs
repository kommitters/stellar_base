defmodule StellarBase.XDR.Operations.ManageBuyOfferResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.ManageBuyOfferResultCode

  @codes [
    :MANAGE_BUY_OFFER_SUCCESS,
    :MANAGE_BUY_OFFER_MALFORMED,
    :MANAGE_BUY_OFFER_SELL_NO_TRUST,
    :MANAGE_BUY_OFFER_BUY_NO_TRUST,
    :MANAGE_BUY_OFFER_SELL_NOT_AUTHORIZED,
    :MANAGE_BUY_OFFER_BUY_NOT_AUTHORIZED,
    :MANAGE_BUY_OFFER_LINE_FULL,
    :MANAGE_BUY_OFFER_UNDERFUNDED,
    :MANAGE_BUY_OFFER_CROSS_SELF,
    :MANAGE_BUY_OFFER_SELL_NO_ISSUER,
    :MANAGE_BUY_OFFER_BUY_NO_ISSUER,
    :MANAGE_BUY_OFFER_NOT_FOUND,
    :MANAGE_BUY_OFFER_LOW_RESERVE
  ]

  describe "ManageBuyOfferResultCode" do
    setup do
      %{
        codes: @codes,
        result: ManageBuyOfferResultCode.new(:MANAGE_BUY_OFFER_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ManageBuyOfferResultCode{identifier: ^type} = ManageBuyOfferResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ManageBuyOfferResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ManageBuyOfferResultCode.encode_xdr(%ManageBuyOfferResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ManageBuyOfferResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ManageBuyOfferResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ManageBuyOfferResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ManageBuyOfferResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%ManageBuyOfferResultCode{identifier: :MANAGE_BUY_OFFER_SELL_NOT_AUTHORIZED}, ""} =
        ManageBuyOfferResultCode.decode_xdr!(<<255, 255, 255, 252>>)
    end
  end
end
