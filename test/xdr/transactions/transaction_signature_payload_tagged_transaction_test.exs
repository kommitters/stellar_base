defmodule StellarBase.XDR.TransactionSignaturePayloadTaggedTransactionTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    EnvelopeType,
    TransactionExt,
    FeeBumpTransactionExt,
    FeeBumpTransactionInnerTx,
    FeeBumpTransaction,
    Int64,
    Memo,
    MemoType,
    PreconditionType,
    Preconditions,
    OptionalMuxedAccount,
    Operation,
    OperationList100,
    SequenceNumber,
    TimeBounds,
    TimePoint,
    Transaction,
    TransactionV1Envelope,
    Uint32,
    Uint64,
    Void
  }

  alias StellarBase.XDR.TransactionSignaturePayloadTaggedTransaction, as: TaggedTransaction

  setup do
    # Seq number
    fee = Uint32.new(100)
    seq_num = SequenceNumber.new(Int64.new(12_345_678))

    # time bounds
    min_time = TimePoint.new(Uint64.new(123))
    max_time = TimePoint.new(Uint64.new(321))
    time_bounds = TimeBounds.new(min_time, max_time)
    precondition_type = PreconditionType.new(:PRECOND_TIME)
    preconditions = Preconditions.new(time_bounds, precondition_type)

    # memo
    memo_type = MemoType.new(:MEMO_ID)
    memo_id = Uint64.new(12_345)
    memo = Memo.new(memo_id, memo_type)

    # operations
    operations = build_operations()

    # ext
    ext = TransactionExt.new(Void.new(), 0)

    {:ok,
     %{
       fee: fee,
       seq_num: seq_num,
       preconditions: preconditions,
       memo: memo,
       operations: operations,
       ext: ext
     }}
  end

  describe "Transaction" do
    setup %{
      fee: fee,
      seq_num: seq_num,
      preconditions: preconditions,
      memo: memo,
      operations: operations,
      ext: ext
    } do
      source_account =
        create_muxed_account("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      tx =
        Transaction.new(
          source_account,
          fee,
          seq_num,
          preconditions,
          memo,
          operations,
          ext
        )

      envelope_type = EnvelopeType.new(:ENVELOPE_TYPE_TX)

      %{
        tx: tx,
        envelope_type: envelope_type,
        tagged_transaction: TaggedTransaction.new(tx, envelope_type),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 100, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123,
            0, 0, 0, 0, 0, 0, 1, 65, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 48, 57, 0, 0, 0, 2, 0, 0, 0, 1,
            0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6, 227, 152, 210, 30, 178, 125, 14, 180,
            37, 218, 186, 125, 140, 233, 21, 108, 175, 188, 190, 189, 62, 75, 154, 219, 0, 0, 0,
            1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149,
            154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2,
            227, 119, 0, 0, 0, 1, 42, 5, 242, 0, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150,
            56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 19, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0,
            0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187,
            173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 108,
            108, 200, 144, 232, 101, 96, 6, 227, 152, 210, 30, 178, 125, 14, 180, 37, 218, 186,
            125, 140, 233, 21, 108, 175, 188, 190, 189, 62, 75, 154, 219, 0, 0, 0, 0, 59, 154,
            202, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{tx: tx, envelope_type: envelope_type} do
      %TaggedTransaction{value: ^tx, type: ^envelope_type} =
        TaggedTransaction.new(tx, envelope_type)
    end

    test "encode_xdr/1", %{tagged_transaction: tagged_transaction, binary: binary} do
      {:ok, ^binary} = TaggedTransaction.encode_xdr(tagged_transaction)
    end

    test "encode_xdr!/1", %{tagged_transaction: tagged_transaction, binary: binary} do
      ^binary = TaggedTransaction.encode_xdr!(tagged_transaction)
    end

    test "decode_xdr/2", %{tagged_transaction: tagged_transaction, binary: binary} do
      {:ok, {^tagged_transaction, ""}} = TaggedTransaction.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TaggedTransaction.decode_xdr(123)
    end

    test "decode_xdr!/2", %{tagged_transaction: tagged_transaction, binary: binary} do
      {^tagged_transaction, ^binary} = TaggedTransaction.decode_xdr!(binary <> binary)
    end
  end

  describe "FeeBumpTransaction" do
    setup %{
      fee: fee,
      seq_num: seq_num,
      preconditions: preconditions,
      memo: memo,
      operations: operations,
      ext: ext
    } do
      source_account =
        create_muxed_account("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      tx =
        Transaction.new(
          source_account,
          fee,
          seq_num,
          preconditions,
          memo,
          operations,
          ext
        )

      envelope_type = EnvelopeType.new(:ENVELOPE_TYPE_TX_FEE_BUMP)

      signatures =
        build_decorated_signatures([
          "SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI",
          "SBVNQLIDS7V3NAOYTATT26QL7Y4S6C2X4YN7PN5FIJ6JUAN4UV4YPLUY"
        ])

      fee_bump_transaction_ext = FeeBumpTransactionExt.new(Void.new(), 0)

      fee_bump_tx =
        tx
        |> TransactionV1Envelope.new(signatures)
        |> FeeBumpTransactionInnerTx.new(EnvelopeType.new(:ENVELOPE_TYPE_TX))
        |> (&FeeBumpTransaction.new(source_account, Int64.new(100_000), &1, fee_bump_transaction_ext)).()

      %{
        tx: fee_bump_tx,
        envelope_type: envelope_type,
        tagged_transaction: TaggedTransaction.new(fee_bump_tx, envelope_type),
        binary:
          <<0, 0, 0, 5, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 1, 134, 160, 0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56,
            85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 100, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0,
            0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0,
            48, 57, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207,
            158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56,
            34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6,
            227, 152, 210, 30, 178, 125, 14, 180, 37, 218, 186, 125, 140, 233, 21, 108, 175, 188,
            190, 189, 62, 75, 154, 219, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178,
            144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210,
            37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 1, 42, 5, 242, 0, 0, 0, 0, 1,
            0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0,
            19, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137,
            68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179,
            73, 138, 2, 227, 119, 0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6, 227, 152, 210,
            30, 178, 125, 14, 180, 37, 218, 186, 125, 140, 233, 21, 108, 175, 188, 190, 189, 62,
            75, 154, 219, 0, 0, 0, 0, 59, 154, 202, 0, 0, 0, 0, 0, 0, 0, 0, 2, 84, 82, 87, 73, 0,
            0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81, 79, 79, 89, 53,
            65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88, 65, 85, 75, 77,
            70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73, 80, 76, 85, 89, 0, 0,
            0, 56, 83, 66, 86, 78, 81, 76, 73, 68, 83, 55, 86, 51, 78, 65, 79, 89, 84, 65, 84, 84,
            50, 54, 81, 76, 55, 89, 52, 83, 54, 67, 50, 88, 52, 89, 78, 55, 80, 78, 53, 70, 73,
            74, 54, 74, 85, 65, 78, 52, 85, 86, 52, 89, 80, 76, 85, 89, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{tx: tx, envelope_type: envelope_type} do
      %TaggedTransaction{value: ^tx, type: ^envelope_type} =
        TaggedTransaction.new(tx, envelope_type)
    end

    test "encode_xdr/1", %{tagged_transaction: tagged_transaction, binary: binary} do
      {:ok, ^binary} = TaggedTransaction.encode_xdr(tagged_transaction)
    end

    test "encode_xdr!/1", %{tagged_transaction: tagged_transaction, binary: binary} do
      ^binary = TaggedTransaction.encode_xdr!(tagged_transaction)
    end

    test "decode_xdr/2", %{tagged_transaction: tagged_transaction, binary: binary} do
      {:ok, {^tagged_transaction, ""}} = TaggedTransaction.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{tagged_transaction: tagged_transaction, binary: binary} do
      {^tagged_transaction, ^binary} = TaggedTransaction.decode_xdr!(binary <> binary)
    end
  end

  @spec build_operations() :: OperationList100.t()
  defp build_operations do
    source_account =
      "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
      |> create_muxed_account()
      |> OptionalMuxedAccount.new()

    destination = create_muxed_account("GBWGZSEQ5BSWABXDTDJB5MT5B22CLWV2PWGOSFLMV66L5PJ6JONNWG24")

    asset =
      create_asset(:alpha_num4,
        code: "BTCN",
        issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      )

    payment_operation = payment_op_body(destination, asset, Int64.new(5_000_000_000))
    clawback_operation = clawback_op_body(asset, destination, Int64.new(1_000_000_000))

    [payment_operation, clawback_operation]
    |> Enum.map(fn op -> Operation.new(source_account, op) end)
    |> OperationList100.new()
  end
end
