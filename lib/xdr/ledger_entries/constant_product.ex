defmodule StellarBase.XDR.ConstantProduct do
  @moduledoc """
  Representation of Stellar `ConstantProduct` type.
  """

  alias StellarBase.XDR.{LiquidityPoolConstantProductParameters, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 params: LiquidityPoolConstantProductParameters,
                 reserve_a: Int64,
                 reserve_b: Int64,
                 total_pool_shares: Int64,
                 pool_shares_trust_line_count: Int64
               )

  @type t :: %__MODULE__{
          params: LiquidityPoolConstantProductParameters.t(),
          reserve_a: Int64.t(),
          reserve_b: Int64.t(),
          total_pool_shares: Int64.t(),
          pool_shares_trust_line_count: Int64.t()
        }

  defstruct [:params, :reserve_a, :reserve_b, :total_pool_shares, :pool_shares_trust_line_count]

  @spec new(
          params :: LiquidityPoolConstantProductParameters.t(),
          reserve_a :: Int64.t(),
          reserve_b :: Int64.t(),
          total_pool_shares :: Int64.t(),
          pool_shares_trust_line_count :: Int64.t()
        ) :: t()
  def new(
        %LiquidityPoolConstantProductParameters{} = params,
        %Int64{} = reserve_a,
        %Int64{} = reserve_b,
        %Int64{} = total_pool_shares,
        %Int64{} = pool_shares_trust_line_count
      ),
      do: %__MODULE__{
        params: params,
        reserve_a: reserve_a,
        reserve_b: reserve_b,
        total_pool_shares: total_pool_shares,
        pool_shares_trust_line_count: pool_shares_trust_line_count
      }

  @impl true
  def encode_xdr(%__MODULE__{
        params: params,
        reserve_a: reserve_a,
        reserve_b: reserve_b,
        total_pool_shares: total_pool_shares,
        pool_shares_trust_line_count: pool_shares_trust_line_count
      }) do
    [
      params: params,
      reserve_a: reserve_a,
      reserve_b: reserve_b,
      total_pool_shares: total_pool_shares,
      pool_shares_trust_line_count: pool_shares_trust_line_count
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        params: params,
        reserve_a: reserve_a,
        reserve_b: reserve_b,
        total_pool_shares: total_pool_shares,
        pool_shares_trust_line_count: pool_shares_trust_line_count
      }) do
    [
      params: params,
      reserve_a: reserve_a,
      reserve_b: reserve_b,
      total_pool_shares: total_pool_shares,
      pool_shares_trust_line_count: pool_shares_trust_line_count
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
            params: params,
            reserve_a: reserve_a,
            reserve_b: reserve_b,
            total_pool_shares: total_pool_shares,
            pool_shares_trust_line_count: pool_shares_trust_line_count
          ]
        }, rest}} ->
        {:ok,
         {new(params, reserve_a, reserve_b, total_pool_shares, pool_shares_trust_line_count),
          rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         params: params,
         reserve_a: reserve_a,
         reserve_b: reserve_b,
         total_pool_shares: total_pool_shares,
         pool_shares_trust_line_count: pool_shares_trust_line_count
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(params, reserve_a, reserve_b, total_pool_shares, pool_shares_trust_line_count), rest}
  end
end
