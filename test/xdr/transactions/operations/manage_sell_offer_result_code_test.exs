defmodule StellarBase.XDR.ManageSellOfferResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ManageSellOfferResultCode

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

  describe "ManageSellOfferResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> ManageSellOfferResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ManageSellOfferResultCode{identifier: ^type} = ManageSellOfferResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ManageSellOfferResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ManageSellOfferResultCode.encode_xdr(%ManageSellOfferResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ManageSellOfferResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ManageSellOfferResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ManageSellOfferResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = ManageSellOfferResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%ManageSellOfferResultCode{identifier: _}, ""} =
              ManageSellOfferResultCode.decode_xdr!(binary)
    end
  end
end
