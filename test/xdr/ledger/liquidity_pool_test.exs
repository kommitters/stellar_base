defmodule Stellar.XDR.Ledger.LiquidityPoolTest do
  use ExUnit.Case

  alias Stellar.XDR.{PoolID, Ledger.LiquidityPool}

  describe "Ledger LiquidityPool" do
    setup do
      pool_id = PoolID.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        pool_id: pool_id,
        liquidity_pool: LiquidityPool.new(pool_id),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1", %{pool_id: pool_id} do
      %LiquidityPool{liquidity_pool_id: ^pool_id} = LiquidityPool.new(pool_id)
    end

    test "encode_xdr/1", %{liquidity_pool: liquidity_pool, binary: binary} do
      {:ok, ^binary} = LiquidityPool.encode_xdr(liquidity_pool)
    end

    test "encode_xdr!/1", %{liquidity_pool: liquidity_pool, binary: binary} do
      ^binary = LiquidityPool.encode_xdr!(liquidity_pool)
    end

    test "decode_xdr/2", %{liquidity_pool: liquidity_pool, binary: binary} do
      {:ok, {^liquidity_pool, ""}} = LiquidityPool.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LiquidityPool.decode_xdr(123)
    end

    test "decode_xdr!/2", %{liquidity_pool: liquidity_pool, binary: binary} do
      {^liquidity_pool, ^binary} = LiquidityPool.decode_xdr!(binary <> binary)
    end
  end
end
