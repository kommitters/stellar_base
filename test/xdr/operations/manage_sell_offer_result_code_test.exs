defmodule Stellar.XDR.Operations.ManageSellOfferResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.ManageSellOfferResultCode

  describe "ManageSellOfferResultCode" do
    setup do
      %{
        code: :MANAGE_SELL_OFFER_SUCCESS,
        result: ManageSellOfferResultCode.new(:MANAGE_SELL_OFFER_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %ManageSellOfferResultCode{identifier: ^type} = ManageSellOfferResultCode.new(type)
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
