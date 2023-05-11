defmodule StellarBase.XDR.LiquidityPoolDepositResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.LiquidityPoolDepositResultCode

  @codes [
    :LIQUIDITY_POOL_DEPOSIT_SUCCESS,
    :LIQUIDITY_POOL_DEPOSIT_MALFORMED,
    :LIQUIDITY_POOL_DEPOSIT_NO_TRUST,
    :LIQUIDITY_POOL_DEPOSIT_NOT_AUTHORIZED,
    :LIQUIDITY_POOL_DEPOSIT_UNDERFUNDED,
    :LIQUIDITY_POOL_DEPOSIT_LINE_FULL,
    :LIQUIDITY_POOL_DEPOSIT_BAD_PRICE,
    :LIQUIDITY_POOL_DEPOSIT_POOL_FULL
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>,
    <<255, 255, 255, 250>>,
    <<255, 255, 255, 249>>
  ]

  describe "LiquidityPoolDepositResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> LiquidityPoolDepositResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %LiquidityPoolDepositResultCode{identifier: ^type} =
              LiquidityPoolDepositResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = LiquidityPoolDepositResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        LiquidityPoolDepositResultCode.encode_xdr(%LiquidityPoolDepositResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = LiquidityPoolDepositResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = LiquidityPoolDepositResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = LiquidityPoolDepositResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = LiquidityPoolDepositResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%LiquidityPoolDepositResultCode{identifier: _}, ""} =
              LiquidityPoolDepositResultCode.decode_xdr!(binary)
    end
  end
end
