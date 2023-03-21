defmodule StellarBase.XDR.LiquidityPoolEntry do
  @moduledoc """
  Representation of Stellar `LiquidityPoolEntry` type.
  """

  alias StellarBase.XDR.{LiquidityPoolEntryBody, PoolID}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(body: LiquidityPoolEntryBody, liquidity_pool_id: PoolID)

  @type t :: %__MODULE__{body: LiquidityPoolEntryBody.t(), liquidity_pool_id: PoolID.t()}

  defstruct [:body, :liquidity_pool_id]

  @spec new(body :: LiquidityPoolEntryBody.t(), liquidity_pool_id :: PoolID.t()) :: t()
  def new(%LiquidityPoolEntryBody{} = body, %PoolID{} = liquidity_pool_id),
    do: %__MODULE__{body: body, liquidity_pool_id: liquidity_pool_id}

  @impl true
  def encode_xdr(%__MODULE__{body: body, liquidity_pool_id: liquidity_pool_id}) do
    [body: body, liquidity_pool_id: liquidity_pool_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{body: body, liquidity_pool_id: liquidity_pool_id}) do
    [body: body, liquidity_pool_id: liquidity_pool_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [body: body, liquidity_pool_id: liquidity_pool_id]
        }, rest}} ->
        {:ok, {new(body, liquidity_pool_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [body: body, liquidity_pool_id: liquidity_pool_id]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(body, liquidity_pool_id), rest}
  end
end
