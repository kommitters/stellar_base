defmodule Stellar.XDR.Ledger.LiquidityPool do
  @moduledoc """
  Representation of Stellar Ledger `LiquidityPool` type.
  """
  alias Stellar.XDR.PoolID

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(liquidity_pool_id: PoolID)

  @type t :: %__MODULE__{liquidity_pool_id: PoolID.t()}

  defstruct [:liquidity_pool_id]

  @spec new(liquidity_pool_id :: PoolID.t()) :: t()
  def new(%PoolID{} = liquidity_pool_id),
    do: %__MODULE__{liquidity_pool_id: liquidity_pool_id}

  @impl true
  def encode_xdr(%__MODULE__{liquidity_pool_id: liquidity_pool_id}) do
    [liquidity_pool_id: liquidity_pool_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{liquidity_pool_id: liquidity_pool_id}) do
    [liquidity_pool_id: liquidity_pool_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [liquidity_pool_id: liquidity_pool_id]}, rest}} ->
        {:ok, {new(liquidity_pool_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [liquidity_pool_id: liquidity_pool_id]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(liquidity_pool_id), rest}
  end
end
