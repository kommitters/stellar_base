defmodule StellarBase.XDR.RevokeID do
  @moduledoc """
  Representation of Stellar `RevokeID` type.
  """
  alias StellarBase.XDR.{AccountID, Asset, PoolID, SequenceNumber, UInt32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 source_account: AccountID,
                 sequence_number: SequenceNumber,
                 op_num: UInt32,
                 liquidity_pool_id: PoolID,
                 asset: Asset
               )

  @type t :: %__MODULE__{
          source_account: AccountID.t(),
          sequence_number: SequenceNumber.t(),
          op_num: UInt32.t(),
          liquidity_pool_id: PoolID.t(),
          asset: Asset.t()
        }

  defstruct [:source_account, :sequence_number, :op_num, :liquidity_pool_id, :asset]

  @spec new(
          source_account :: AccountID.t(),
          sequence_number :: SequenceNumber.t(),
          op_num :: UInt32.t(),
          liquidity_pool_id :: PoolID.t(),
          asset :: Asset.t()
        ) :: t()
  def new(
        %AccountID{} = source_account,
        %SequenceNumber{} = sequence_number,
        %UInt32{} = op_num,
        %PoolID{} = pool_id,
        %Asset{} = asset
      ) do
    %__MODULE__{
      source_account: source_account,
      sequence_number: sequence_number,
      op_num: op_num,
      liquidity_pool_id: pool_id,
      asset: asset
    }
  end

  @impl true
  def encode_xdr(%__MODULE__{
        source_account: source_account,
        sequence_number: sequence_number,
        op_num: op_num,
        liquidity_pool_id: pool_id,
        asset: asset
      }) do
    [
      source_account: source_account,
      sequence_number: sequence_number,
      op_num: op_num,
      liquidity_pool_id: pool_id,
      asset: asset
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        source_account: source_account,
        sequence_number: sequence_number,
        op_num: op_num,
        liquidity_pool_id: pool_id,
        asset: asset
      }) do
    [
      source_account: source_account,
      sequence_number: sequence_number,
      op_num: op_num,
      liquidity_pool_id: pool_id,
      asset: asset
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
            source_account: source_account,
            sequence_number: sequence_number,
            op_num: op_num,
            liquidity_pool_id: pool_id,
            asset: asset
          ]
        }, rest}} ->
        {:ok, {new(source_account, sequence_number, op_num, pool_id, asset), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         source_account: source_account,
         sequence_number: sequence_number,
         op_num: op_num,
         liquidity_pool_id: pool_id,
         asset: asset
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(source_account, sequence_number, op_num, pool_id, asset), rest}
  end
end
