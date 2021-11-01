defmodule Stellar.XDR.Operations.LiquidityPoolWithdrawResultTest do
  use ExUnit.Case

  alias Stellar.XDR.Void
  alias Stellar.XDR.Operations.{LiquidityPoolWithdrawResult, LiquidityPoolWithdrawResultCode}

  describe "LiquidityPoolWithdrawResult" do
    setup do
      code = LiquidityPoolWithdrawResultCode.new(:LIQUIDITY_POOL_WITHDRAW_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: LiquidityPoolWithdrawResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %LiquidityPoolWithdrawResult{code: ^code, result: ^value} =
        LiquidityPoolWithdrawResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = LiquidityPoolWithdrawResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = LiquidityPoolWithdrawResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = LiquidityPoolWithdrawResult.new("TEST", code)
      ^binary = LiquidityPoolWithdrawResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = LiquidityPoolWithdrawResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = LiquidityPoolWithdrawResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%LiquidityPoolWithdrawResult{
         code: %LiquidityPoolWithdrawResultCode{identifier: :LIQUIDITY_POOL_WITHDRAW_NO_TRUST}
       }, ""} = LiquidityPoolWithdrawResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LiquidityPoolWithdrawResult.decode_xdr(123)
    end
  end
end
