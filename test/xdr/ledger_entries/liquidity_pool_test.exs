defmodule StellarBase.XDR.LedgerKeyLiquidityPoolTest do
  use ExUnit.Case

  alias StellarBase.XDR.{PoolID, LedgerKeyLiquidityPool, Hash}

  describe "Ledger LedgerKeyLiquidityPool" do
    setup do
      pool_id =
        "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
        |> Hash.new()
        |> PoolID.new()

      %{
        pool_id: pool_id,
        liquidity_pool: LedgerKeyLiquidityPool.new(pool_id),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1", %{pool_id: pool_id} do
      %LedgerKeyLiquidityPool{liquidity_pool_id: ^pool_id} = LedgerKeyLiquidityPool.new(pool_id)
    end

    test "encode_xdr/1", %{liquidity_pool: liquidity_pool, binary: binary} do
      {:ok, ^binary} = LedgerKeyLiquidityPool.encode_xdr(liquidity_pool)
    end

    test "encode_xdr!/1", %{liquidity_pool: liquidity_pool, binary: binary} do
      ^binary = LedgerKeyLiquidityPool.encode_xdr!(liquidity_pool)
    end

    test "decode_xdr/2", %{liquidity_pool: liquidity_pool, binary: binary} do
      {:ok, {^liquidity_pool, ""}} = LedgerKeyLiquidityPool.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyLiquidityPool.decode_xdr(123)
    end

    test "decode_xdr!/2", %{liquidity_pool: liquidity_pool, binary: binary} do
      {^liquidity_pool, ^binary} = LedgerKeyLiquidityPool.decode_xdr!(binary <> binary)
    end
  end
end
