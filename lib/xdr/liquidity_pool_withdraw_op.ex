defmodule StellarBase.XDR.LiquidityPoolWithdrawOp do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `LiquidityPoolWithdrawOp` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    PoolID,
    Int64
  }

  @struct_spec XDR.Struct.new(
    liquidity_pool_id: PoolID,
    amount: Int64,
    min_amount_a: Int64,
    min_amount_b: Int64
  )

  @type type_liquidity_pool_id :: PoolID.t()
  @type type_amount :: Int64.t()
  @type type_min_amount_a :: Int64.t()
  @type type_min_amount_b :: Int64.t()

  @type t :: %__MODULE__{liquidity_pool_id: type_liquidity_pool_id(), amount: type_amount(), min_amount_a: type_min_amount_a(), min_amount_b: type_min_amount_b()}

  defstruct [:liquidity_pool_id, :amount, :min_amount_a, :min_amount_b]

  @spec new(liquidity_pool_id :: type_liquidity_pool_id(), amount :: type_amount(), min_amount_a :: type_min_amount_a(), min_amount_b :: type_min_amount_b()) :: t()
  def new(
    %PoolID{} = liquidity_pool_id,
    %Int64{} = amount,
    %Int64{} = min_amount_a,
    %Int64{} = min_amount_b
  ),
  do: %__MODULE__{liquidity_pool_id: liquidity_pool_id, amount: amount, min_amount_a: min_amount_a, min_amount_b: min_amount_b}

  @impl true
  def encode_xdr(%__MODULE__{liquidity_pool_id: liquidity_pool_id, amount: amount, min_amount_a: min_amount_a, min_amount_b: min_amount_b}) do
    [liquidity_pool_id: liquidity_pool_id, amount: amount, min_amount_a: min_amount_a, min_amount_b: min_amount_b]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{liquidity_pool_id: liquidity_pool_id, amount: amount, min_amount_a: min_amount_a, min_amount_b: min_amount_b}) do
    [liquidity_pool_id: liquidity_pool_id, amount: amount, min_amount_a: min_amount_a, min_amount_b: min_amount_b]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [liquidity_pool_id: liquidity_pool_id, amount: amount, min_amount_a: min_amount_a, min_amount_b: min_amount_b]}, rest}} ->
        {:ok, {new(liquidity_pool_id, amount, min_amount_a, min_amount_b), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [liquidity_pool_id: liquidity_pool_id, amount: amount, min_amount_a: min_amount_a, min_amount_b: min_amount_b]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(liquidity_pool_id, amount, min_amount_a, min_amount_b), rest}
  end
end
