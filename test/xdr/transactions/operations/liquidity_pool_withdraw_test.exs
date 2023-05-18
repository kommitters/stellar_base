defmodule StellarBase.XDR.LiquidityPoolWithdrawOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Int64, PoolID, Hash}
  alias StellarBase.XDR.LiquidityPoolWithdrawOp

  describe "LiquidityPoolDeposit Operation" do
    setup do
      pool_id = PoolID.new(Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"))
      amount = Int64.new(10_000_000)
      min_amount_a = Int64.new(5_000_000)
      min_amount_b = Int64.new(2_000_000)

      %{
        pool_id: pool_id,
        amount: amount,
        min_amount_a: min_amount_a,
        min_amount_b: min_amount_b,
        liquid_pool_withdraw:
          LiquidityPoolWithdrawOp.new(pool_id, amount, min_amount_a, min_amount_b),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 0, 152, 150, 128, 0, 0, 0, 0,
            0, 76, 75, 64, 0, 0, 0, 0, 0, 30, 132, 128>>
      }
    end

    test "new/1", %{
      pool_id: pool_id,
      amount: amount,
      min_amount_a: min_amount_a,
      min_amount_b: min_amount_b
    } do
      %LiquidityPoolWithdrawOp{
        liquidity_pool_id: ^pool_id,
        amount: ^amount,
        min_amount_a: ^min_amount_a,
        min_amount_b: ^min_amount_b
      } = LiquidityPoolWithdrawOp.new(pool_id, amount, min_amount_a, min_amount_b)
    end

    test "encode_xdr/1", %{liquid_pool_withdraw: liquid_pool_withdraw, binary: binary} do
      {:ok, ^binary} = LiquidityPoolWithdrawOp.encode_xdr(liquid_pool_withdraw)
    end

    test "encode_xdr!/1", %{liquid_pool_withdraw: liquid_pool_withdraw, binary: binary} do
      ^binary = LiquidityPoolWithdrawOp.encode_xdr!(liquid_pool_withdraw)
    end

    test "decode_xdr/2", %{liquid_pool_withdraw: liquid_pool_withdraw, binary: binary} do
      {:ok, {^liquid_pool_withdraw, ""}} = LiquidityPoolWithdrawOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LiquidityPoolWithdrawOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{liquid_pool_withdraw: liquid_pool_withdraw, binary: binary} do
      {^liquid_pool_withdraw, ^binary} = LiquidityPoolWithdrawOp.decode_xdr!(binary <> binary)
    end
  end
end
