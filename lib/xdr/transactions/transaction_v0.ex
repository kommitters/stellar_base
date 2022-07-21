defmodule StellarBase.XDR.TransactionV0 do
  @moduledoc """
  Representation of Stellar `TransactionV0` type.

  TransactionV0 is a transaction with the AccountID discriminant stripped off,
  leaving a raw ed25519 public key to identify the source account. This is used
  for backwards compatibility starting from the protocol 12/13 boundary.

  If an "old-style" TransactionEnvelope containing a Transaction is parsed with this
  XDR definition, it will be parsed as a "new-style" TransactionEnvelope
  containing a TransactionV0.
  """

  alias StellarBase.XDR.{
    Ext,
    Memo,
    Preconditions,
    Operations,
    SequenceNumber,
    UInt32,
    UInt256
  }

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 source_account_ed25519: UInt256,
                 fee: UInt32,
                 seq_num: SequenceNumber,
                 preconditions: Preconditions,
                 memo: Memo,
                 operations: Operations,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          source_account_ed25519: UInt256.t(),
          fee: UInt32.t(),
          seq_num: SequenceNumber.t(),
          preconditions: Preconditions.t(),
          memo: Memo.t(),
          operations: Operations.t(),
          ext: Ext.t()
        }

  defstruct [:source_account_ed25519, :fee, :seq_num, :preconditions, :memo, :operations, :ext]

  @spec new(
          source_account_ed25519 :: UInt256.t(),
          fee :: UInt32.t(),
          seq_num :: SequenceNumber.t(),
          preconditions :: Preconditions.t(),
          memo :: Memo.t(),
          operations :: Operations.t(),
          ext :: Ext.t()
        ) :: t()
  def new(
        %UInt256{} = source_account_ed25519,
        %UInt32{} = fee,
        %SequenceNumber{} = seq_num,
        %Preconditions{} = preconditions,
        %Memo{} = memo,
        %Operations{} = operations,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        source_account_ed25519: source_account_ed25519,
        fee: fee,
        seq_num: seq_num,
        preconditions: preconditions,
        memo: memo,
        operations: operations,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        source_account_ed25519: source_account_ed25519,
        fee: fee,
        seq_num: seq_num,
        preconditions: preconditions,
        memo: memo,
        operations: operations,
        ext: ext
      }) do
    [
      source_account_ed25519: source_account_ed25519,
      fee: fee,
      seq_num: seq_num,
      preconditions: preconditions,
      memo: memo,
      operations: operations,
      ext: ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        source_account_ed25519: source_account_ed25519,
        fee: fee,
        seq_num: seq_num,
        preconditions: preconditions,
        memo: memo,
        operations: operations,
        ext: ext
      }) do
    [
      source_account_ed25519: source_account_ed25519,
      fee: fee,
      seq_num: seq_num,
      preconditions: preconditions,
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
            source_account_ed25519: source_account_ed25519,
            fee: fee,
            seq_num: seq_num,
            preconditions: preconditions,
            memo: memo,
            operations: operations,
            ext: ext
          ]
        }, rest}} ->
        {:ok,
         {new(source_account_ed25519, fee, seq_num, preconditions, memo, operations, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         source_account_ed25519: source_account_ed25519,
         fee: fee,
         seq_num: seq_num,
         preconditions: preconditions,
         memo: memo,
         operations: operations,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(source_account_ed25519, fee, seq_num, preconditions, memo, operations, ext), rest}
  end
end
