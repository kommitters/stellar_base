defmodule StellarBase.XDR.LiquidityPoolDepositResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.{LiquidityPoolDepositResult, LiquidityPoolDepositResultCode}

  describe "LiquidityPoolDepositResult" do
    setup do
      code = LiquidityPoolDepositResultCode.new(:LIQUIDITY_POOL_DEPOSIT_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: LiquidityPoolDepositResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %LiquidityPoolDepositResult{value: ^code, type: ^value} =
        LiquidityPoolDepositResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = LiquidityPoolDepositResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = LiquidityPoolDepositResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = LiquidityPoolDepositResult.new("TEST", code)
      ^binary = LiquidityPoolDepositResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = LiquidityPoolDepositResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = LiquidityPoolDepositResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%LiquidityPoolDepositResult{
         value: %LiquidityPoolDepositResultCode{identifier: :LIQUIDITY_POOL_DEPOSIT_NO_TRUST}
       }, ""} = LiquidityPoolDepositResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LiquidityPoolDepositResult.decode_xdr(123)
    end
  end
end
