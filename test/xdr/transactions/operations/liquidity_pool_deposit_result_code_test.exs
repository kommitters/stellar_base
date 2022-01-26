defmodule StellarBase.XDR.Operations.LiquidityPoolDepositResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.LiquidityPoolDepositResultCode

  describe "LiquidityPoolDepositResultCode" do
    setup do
      %{
        code: :LIQUIDITY_POOL_DEPOSIT_SUCCESS,
        result: LiquidityPoolDepositResultCode.new(:LIQUIDITY_POOL_DEPOSIT_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %LiquidityPoolDepositResultCode{identifier: ^type} =
        LiquidityPoolDepositResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = LiquidityPoolDepositResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        LiquidityPoolDepositResultCode.encode_xdr(%LiquidityPoolDepositResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = LiquidityPoolDepositResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = LiquidityPoolDepositResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = LiquidityPoolDepositResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = LiquidityPoolDepositResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%LiquidityPoolDepositResultCode{identifier: :LIQUIDITY_POOL_DEPOSIT_NO_TRUST}, ""} =
        LiquidityPoolDepositResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
