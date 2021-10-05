defmodule Stellar.XDR.Operations.LiquidityPoolDeposit do
  @moduledoc """
  Representation of Stellar `LiquidityPoolDeposit` type.
  """
  alias Stellar.XDR.{PoolID, Int64, Price}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 pool_id: PoolID,
                 max_amount_a: Int64,
                 max_amount_b: Int64,
                 min_price: Price,
                 max_price: Price
               )

  @type t :: %__MODULE__{
          pool_id: PoolID.t(),
          max_amount_a: Int64.t(),
          max_amount_b: Int64.t(),
          min_price: Price.t(),
          max_price: Price.t()
        }

  defstruct [:pool_id, :max_amount_a, :max_amount_b, :min_price, :max_price]

  @spec new(
          pool_id :: PoolID.t(),
          max_amount_a :: Int64.t(),
          max_amount_b :: Int64.t(),
          min_price :: Price.t(),
          max_price :: Price.t()
        ) :: t()
  def new(
        %PoolID{} = pool_id,
        %Int64{} = max_amount_a,
        %Int64{} = max_amount_b,
        %Price{} = min_price,
        %Price{} = max_price
      ),
      do: %__MODULE__{
        pool_id: pool_id,
        max_amount_a: max_amount_a,
        max_amount_b: max_amount_b,
        min_price: min_price,
        max_price: max_price
      }

  @impl true
  def encode_xdr(%__MODULE__{
        pool_id: pool_id,
        max_amount_a: max_amount_a,
        max_amount_b: max_amount_b,
        min_price: min_price,
        max_price: max_price
      }) do
    [
      pool_id: pool_id,
      max_amount_a: max_amount_a,
      max_amount_b: max_amount_b,
      min_price: min_price,
      max_price: max_price
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        pool_id: pool_id,
        max_amount_a: max_amount_a,
        max_amount_b: max_amount_b,
        min_price: min_price,
        max_price: max_price
      }) do
    [
      pool_id: pool_id,
      max_amount_a: max_amount_a,
      max_amount_b: max_amount_b,
      min_price: min_price,
      max_price: max_price
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
            max_amount_a: max_amount_a,
            max_amount_b: max_amount_b,
            min_price: min_price,
            max_price: max_price
          ]
        }, rest}} ->
        {:ok, {new(pool_id, max_amount_a, max_amount_b, min_price, max_price), rest}}

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
         max_amount_a: max_amount_a,
         max_amount_b: max_amount_b,
         min_price: min_price,
         max_price: max_price
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(pool_id, max_amount_a, max_amount_b, min_price, max_price), rest}
  end
end
