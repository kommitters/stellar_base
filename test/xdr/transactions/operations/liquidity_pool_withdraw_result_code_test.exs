defmodule StellarBase.XDR.LiquidityPoolWithdrawResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.LiquidityPoolWithdrawResultCode

  @codes [
    :LIQUIDITY_POOL_WITHDRAW_SUCCESS,
    :LIQUIDITY_POOL_WITHDRAW_MALFORMED,
    :LIQUIDITY_POOL_WITHDRAW_NO_TRUST,
    :LIQUIDITY_POOL_WITHDRAW_UNDERFUNDED,
    :LIQUIDITY_POOL_WITHDRAW_LINE_FULL,
    :LIQUIDITY_POOL_WITHDRAW_UNDER_MINIMUM
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>
  ]

  describe "LiquidityPoolWithdrawResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> LiquidityPoolWithdrawResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %LiquidityPoolWithdrawResultCode{identifier: ^type} =
              LiquidityPoolWithdrawResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = LiquidityPoolWithdrawResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        LiquidityPoolWithdrawResultCode.encode_xdr(%LiquidityPoolWithdrawResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = LiquidityPoolWithdrawResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = LiquidityPoolWithdrawResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = LiquidityPoolWithdrawResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = LiquidityPoolWithdrawResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%LiquidityPoolWithdrawResultCode{identifier: _}, ""} =
              LiquidityPoolWithdrawResultCode.decode_xdr!(binary)
    end
  end
end
