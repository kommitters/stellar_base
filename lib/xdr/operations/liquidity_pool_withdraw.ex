defmodule Stellar.XDR.Operations.LiquidityPoolWithdraw do
  @moduledoc """
  Representation of Stellar `LiquidityPoolWithdraw` type.
  """
  alias Stellar.XDR.{PoolID, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 pool_id: PoolID,
                 amount: Int64,
                 min_amount_a: Int64,
                 min_amount_b: Int64
               )

  @type t :: %__MODULE__{
          pool_id: PoolID.t(),
          amount: Int64.t(),
          min_amount_a: Int64.t(),
          min_amount_b: Int64.t()
        }

  defstruct [:pool_id, :amount, :min_amount_a, :min_amount_b]

  @spec new(
          pool_id :: PoolID.t(),
          amount :: Int64.t(),
          min_amount_a :: Int64.t(),
          min_amount_b :: Int64.t()
        ) :: t()
  def new(
        %PoolID{} = pool_id,
        %Int64{} = amount,
        %Int64{} = min_amount_a,
        %Int64{} = min_amount_b
      ),
      do: %__MODULE__{
        pool_id: pool_id,
        amount: amount,
        min_amount_a: min_amount_a,
        min_amount_b: min_amount_b
      }

  @impl true
  def encode_xdr(%__MODULE__{
        pool_id: pool_id,
        amount: amount,
        min_amount_a: min_amount_a,
        min_amount_b: min_amount_b
      }) do
    [
      pool_id: pool_id,
      amount: amount,
      min_amount_a: min_amount_a,
      min_amount_b: min_amount_b
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        pool_id: pool_id,
        amount: amount,
        min_amount_a: min_amount_a,
        min_amount_b: min_amount_b
      }) do
    [
      pool_id: pool_id,
      amount: amount,
      min_amount_a: min_amount_a,
      min_amount_b: min_amount_b
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            pool_id: pool_id,
            amount: amount,
            min_amount_a: min_amount_a,
            min_amount_b: min_amount_b
          ]
        }, rest}} ->
        {:ok, {new(pool_id, amount, min_amount_a, min_amount_b), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         pool_id: pool_id,
         amount: amount,
         min_amount_a: min_amount_a,
         min_amount_b: min_amount_b
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(pool_id, amount, min_amount_a, min_amount_b), rest}
  end
end
