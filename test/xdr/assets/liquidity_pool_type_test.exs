defmodule StellarBase.XDR.LiquidityPoolTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.LiquidityPoolType

  describe "LiquidityPoolType" do
    setup do
      %{
        identifier: :LIQUIDITY_POOL_CONSTANT_PRODUCT,
        operation_type: LiquidityPoolType.new(:LIQUIDITY_POOL_CONSTANT_PRODUCT),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{identifier: type} do
      %LiquidityPoolType{identifier: ^type} = LiquidityPoolType.new(type)
    end

    test "new/1 with an invalid type" do
      %LiquidityPoolType{identifier: nil} = LiquidityPoolType.new(nil)
    end

    test "encode_xdr/1", %{operation_type: operation_type, binary: binary} do
      {:ok, ^binary} = LiquidityPoolType.encode_xdr(operation_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        LiquidityPoolType.encode_xdr(%LiquidityPoolType{identifier: :BUY_MONEY})
    end

    test "encode_xdr!/1", %{operation_type: operation_type, binary: binary} do
      ^binary = LiquidityPoolType.encode_xdr!(operation_type)
    end

    test "decode_xdr/2", %{operation_type: operation_type, binary: binary} do
      {:ok, {^operation_type, ""}} = LiquidityPoolType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = LiquidityPoolType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{operation_type: operation_type, binary: binary} do
      {^operation_type, ^binary} = LiquidityPoolType.decode_xdr!(binary <> binary)
    end
  end
end
