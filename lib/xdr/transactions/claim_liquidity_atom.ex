defmodule StellarBase.XDR.ClaimLiquidityAtom do
  @moduledoc """
  Representation of Stellar `ClaimLiquidityAtom` type.
  """

  alias StellarBase.XDR.{Asset, Int64, PoolID}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 liquidity_pool_id: PoolID,
                 asset_sold: Asset,
                 amount_sold: Int64,
                 asset_bought: Asset,
                 amount_bought: Int64
               )

  @type t :: %__MODULE__{
          liquidity_pool_id: PoolID.t(),
          asset_sold: Asset.t(),
          amount_sold: Int64.t(),
          asset_bought: Asset.t(),
          amount_bought: Int64.t()
        }

  defstruct [:liquidity_pool_id, :asset_sold, :amount_sold, :asset_bought, :amount_bought]

  @spec new(
          liquidity_pool_id :: PoolID.t(),
          asset_sold :: Asset.t(),
          amount_sold :: Int64.t(),
          asset_bought :: Asset.t(),
          amount_bought :: Int64.t()
        ) :: t()
  def new(
        %PoolID{} = liquidity_pool_id,
        %Asset{} = asset_sold,
        %Int64{} = amount_sold,
        %Asset{} = asset_bought,
        %Int64{} = amount_bought
      ),
      do: %__MODULE__{
        liquidity_pool_id: liquidity_pool_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }

  @impl true
  def encode_xdr(%__MODULE__{
        liquidity_pool_id: liquidity_pool_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }) do
    [
      liquidity_pool_id: liquidity_pool_id,
      asset_sold: asset_sold,
      amount_sold: amount_sold,
      asset_bought: asset_bought,
      amount_bought: amount_bought
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        liquidity_pool_id: liquidity_pool_id,
        asset_sold: asset_sold,
        amount_sold: amount_sold,
        asset_bought: asset_bought,
        amount_bought: amount_bought
      }) do
    [
      liquidity_pool_id: liquidity_pool_id,
      asset_sold: asset_sold,
      amount_sold: amount_sold,
      asset_bought: asset_bought,
      amount_bought: amount_bought
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
            liquidity_pool_id: liquidity_pool_id,
            asset_sold: asset_sold,
            amount_sold: amount_sold,
            asset_bought: asset_bought,
            amount_bought: amount_bought
          ]
        }, rest}} ->
        {:ok,
         {new(liquidity_pool_id, asset_sold, amount_sold, asset_bought, amount_bought), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         liquidity_pool_id: liquidity_pool_id,
         asset_sold: asset_sold,
         amount_sold: amount_sold,
         asset_bought: asset_bought,
         amount_bought: amount_bought
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(liquidity_pool_id, asset_sold, amount_sold, asset_bought, amount_bought), rest}
  end
end
