defmodule StellarBase.XDR.Operations.LiquidityPoolWithdrawResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.LiquidityPoolWithdrawResultCode

  @codes [
    :LIQUIDITY_POOL_WITHDRAW_SUCCESS,
    :LIQUIDITY_POOL_WITHDRAW_MALFORMED,
    :LIQUIDITY_POOL_WITHDRAW_NO_TRUST,
    :LIQUIDITY_POOL_WITHDRAW_UNDERFUNDED,
    :LIQUIDITY_POOL_WITHDRAW_LINE_FULL,
    :LIQUIDITY_POOL_WITHDRAW_UNDER_MINIMUM
  ]

  describe "LiquidityPoolWithdrawResultCode" do
    setup do
      %{
        codes: @codes,
        result: LiquidityPoolWithdrawResultCode.new(:LIQUIDITY_POOL_WITHDRAW_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %LiquidityPoolWithdrawResultCode{identifier: ^type} =
              LiquidityPoolWithdrawResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = LiquidityPoolWithdrawResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        LiquidityPoolWithdrawResultCode.encode_xdr(%LiquidityPoolWithdrawResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = LiquidityPoolWithdrawResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = LiquidityPoolWithdrawResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = LiquidityPoolWithdrawResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = LiquidityPoolWithdrawResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%LiquidityPoolWithdrawResultCode{identifier: :LIQUIDITY_POOL_WITHDRAW_NO_TRUST}, ""} =
        LiquidityPoolWithdrawResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
