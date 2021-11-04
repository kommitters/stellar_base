defmodule StellarBase.XDR.Transaction do
  @moduledoc """
  Representation of Stellar `Transaction` type.
  """

  alias StellarBase.XDR.{
    Ext,
    Memo,
    MuxedAccount,
    OptionalTimeBounds,
    Operations,
    SequenceNumber,
    UInt32
  }

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 source_account: MuxedAccount,
                 fee: UInt32,
                 seq_num: SequenceNumber,
                 time_bounds: OptionalTimeBounds,
                 memo: Memo,
                 operations: Operations,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          source_account: MuxedAccount.t(),
          fee: UInt32.t(),
          seq_num: SequenceNumber.t(),
          time_bounds: OptionalTimeBounds.t(),
          memo: Memo.t(),
          operations: Operations.t(),
          ext: Ext.t()
        }

  defstruct [:source_account, :fee, :seq_num, :time_bounds, :memo, :operations, :ext]

  @spec new(
          source_account :: MuxedAccount.t(),
          fee :: UInt32.t(),
          seq_num :: SequenceNumber.t(),
          time_bounds :: OptionalTimeBounds.t(),
          memo :: Memo.t(),
          operations :: Operations.t(),
          ext :: Ext.t()
        ) :: t()
  def new(
        %MuxedAccount{} = source_account,
        %UInt32{} = fee,
        %SequenceNumber{} = seq_num,
        %OptionalTimeBounds{} = time_bounds,
        %Memo{} = memo,
        %Operations{} = operations,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        source_account: source_account,
        fee: fee,
        seq_num: seq_num,
        time_bounds: time_bounds,
        memo: memo,
        operations: operations,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        source_account: source_account,
        fee: fee,
        seq_num: seq_num,
        time_bounds: time_bounds,
        memo: memo,
        operations: operations,
        ext: ext
      }) do
    [
      source_account: source_account,
      fee: fee,
      seq_num: seq_num,
      time_bounds: time_bounds,
      memo: memo,
      operations: operations,
      ext: ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        source_account: source_account,
        fee: fee,
        seq_num: seq_num,
        time_bounds: time_bounds,
        memo: memo,
        operations: operations,
        ext: ext
      }) do
    [
      source_account: source_account,
      fee: fee,
      seq_num: seq_num,
      time_bounds: time_bounds,
      memo: memo,
      operations: operations,
      ext: ext
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
            fee: fee,
            seq_num: seq_num,
            time_bounds: time_bounds,
            memo: memo,
            operations: operations,
            ext: ext
          ]
        }, rest}} ->
        {:ok, {new(source_account, fee, seq_num, time_bounds, memo, operations, ext), rest}}

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
         fee: fee,
         seq_num: seq_num,
         time_bounds: time_bounds,
         memo: memo,
         operations: operations,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(source_account, fee, seq_num, time_bounds, memo, operations, ext), rest}
  end
end
