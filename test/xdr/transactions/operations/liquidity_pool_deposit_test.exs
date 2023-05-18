defmodule StellarBase.XDR.LiquidityPoolDepositOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Int32, Int64, PoolID, Price, Hash}
  alias StellarBase.XDR.LiquidityPoolDepositOp

  describe "LiquidityPoolDepositOp Operation" do
    setup do
      pool_id = PoolID.new(Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"))
      max_amount_a = Int64.new(1_000_000)
      max_amount_b = Int64.new(5_000_000)
      min_price = Price.new(Int32.new(10), Int32.new(100))
      max_price = Price.new(Int32.new(10), Int32.new(10))

      %{
        pool_id: pool_id,
        max_amount_a: max_amount_a,
        max_amount_b: max_amount_b,
        min_price: min_price,
        max_price: max_price,
        liquid_pool_deposit:
          LiquidityPoolDepositOp.new(pool_id, max_amount_a, max_amount_b, min_price, max_price),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 0, 15, 66, 64, 0, 0, 0, 0, 0,
            76, 75, 64, 0, 0, 0, 10, 0, 0, 0, 100, 0, 0, 0, 10, 0, 0, 0, 10>>
      }
    end

    test "new/1", %{
      pool_id: pool_id,
      max_amount_a: max_amount_a,
      max_amount_b: max_amount_b,
      min_price: min_price,
      max_price: max_price
    } do
      %LiquidityPoolDepositOp{
        liquidity_pool_id: ^pool_id,
        max_amount_a: ^max_amount_a,
        max_amount_b: ^max_amount_b,
        min_price: ^min_price,
        max_price: ^max_price
      } = LiquidityPoolDepositOp.new(pool_id, max_amount_a, max_amount_b, min_price, max_price)
    end

    test "encode_xdr/1", %{liquid_pool_deposit: liquid_pool_deposit, binary: binary} do
      {:ok, ^binary} = LiquidityPoolDepositOp.encode_xdr(liquid_pool_deposit)
    end

    test "encode_xdr!/1", %{liquid_pool_deposit: liquid_pool_deposit, binary: binary} do
      ^binary = LiquidityPoolDepositOp.encode_xdr!(liquid_pool_deposit)
    end

    test "decode_xdr/2", %{liquid_pool_deposit: liquid_pool_deposit, binary: binary} do
      {:ok, {^liquid_pool_deposit, ""}} = LiquidityPoolDepositOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LiquidityPoolDepositOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{liquid_pool_deposit: liquid_pool_deposit, binary: binary} do
      {^liquid_pool_deposit, ^binary} = LiquidityPoolDepositOp.decode_xdr!(binary <> binary)
    end
  end
end
