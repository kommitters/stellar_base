defmodule StellarBase.XDR.FeeBumpTransactionInnerTxTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    EnvelopeType,
    TransactionExt,
    FeeBumpTransactionInnerTx,
    Int64,
    Memo,
    MemoType,
    Operation,
    OperationList100,
    OptionalMuxedAccount,
    Preconditions,
    PreconditionType,
    SequenceNumber,
    TimeBounds,
    TimePoint,
    Transaction,
    TransactionV1Envelope,
    Uint32,
    Uint64,
    Void
  }

  describe "FeeBumpTransactionInnerTx" do
    setup do
      transaction_v1 = build_transaction_v1()

      signatures =
        build_decorated_signatures([
          "SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI",
          "SBVNQLIDS7V3NAOYTATT26QL7Y4S6C2X4YN7PN5FIJ6JUAN4UV4YPLUY"
        ])

      envelope_type = EnvelopeType.new(:ENVELOPE_TYPE_TX)

      tx_envelope = TransactionV1Envelope.new(transaction_v1, signatures)

      %{
        envelope_type: envelope_type,
        tx_envelope: tx_envelope,
        fee_bump_inner_tx: FeeBumpTransactionInnerTx.new(tx_envelope, envelope_type),
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
            202, 0, 0, 0, 0, 0, 0, 0, 0, 2, 84, 82, 87, 73, 0, 0, 0, 56, 83, 65, 80, 86, 86, 85,
            81, 50, 71, 55, 53, 53, 75, 71, 81, 79, 79, 89, 53, 65, 51, 65, 71, 84, 77, 87, 67,
            67, 81, 81, 84, 74, 77, 71, 83, 88, 65, 85, 75, 77, 70, 84, 52, 53, 79, 70, 67, 76,
            55, 78, 67, 83, 84, 82, 87, 73, 80, 76, 85, 89, 0, 0, 0, 56, 83, 66, 86, 78, 81, 76,
            73, 68, 83, 55, 86, 51, 78, 65, 79, 89, 84, 65, 84, 84, 50, 54, 81, 76, 55, 89, 52,
            83, 54, 67, 50, 88, 52, 89, 78, 55, 80, 78, 53, 70, 73, 74, 54, 74, 85, 65, 78, 52,
            85, 86, 52, 89, 80, 76, 85, 89>>
      }
    end

    test "new/1", %{tx_envelope: tx_envelope, envelope_type: envelope_type} do
      %FeeBumpTransactionInnerTx{
        value: ^tx_envelope,
        type: ^envelope_type
      } = FeeBumpTransactionInnerTx.new(tx_envelope, envelope_type)
    end

    test "encode_xdr/1", %{fee_bump_inner_tx: fee_bump_inner_tx, binary: binary} do
      {:ok, ^binary} = FeeBumpTransactionInnerTx.encode_xdr(fee_bump_inner_tx)
    end

    test "encode_xdr!/1", %{fee_bump_inner_tx: fee_bump_inner_tx, binary: binary} do
      ^binary = FeeBumpTransactionInnerTx.encode_xdr!(fee_bump_inner_tx)
    end

    test "decode_xdr/2", %{fee_bump_inner_tx: fee_bump_inner_tx, binary: binary} do
      {:ok, {^fee_bump_inner_tx, ""}} = FeeBumpTransactionInnerTx.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{fee_bump_inner_tx: fee_bump_inner_tx, binary: binary} do
      {^fee_bump_inner_tx, ^binary} = FeeBumpTransactionInnerTx.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = FeeBumpTransactionInnerTx.decode_xdr(123)
    end

    test "invalid identifier", %{envelope_type: envelope_type} do
      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     envelope_type
                     |> FeeBumpTransactionInnerTx.new(EnvelopeType.new(:TEST))
                     |> FeeBumpTransactionInnerTx.encode_xdr()
                   end
    end
  end

  @spec build_transaction_v1() :: TransactionV0.t()
  defp build_transaction_v1 do
    source_account =
      create_muxed_account("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

    fee = Uint32.new(100)
    seq_num = SequenceNumber.new(Int64.new(12_345_678))

    # preconditions
    min_time = TimePoint.new(123)
    max_time = TimePoint.new(321)
    time_bounds = TimeBounds.new(min_time, max_time)
    precondition_type = PreconditionType.new(:PRECOND_TIME)
    preconditions = Preconditions.new(time_bounds, precondition_type)

    # memo
    memo_type = MemoType.new(:MEMO_ID)
    memo_id = Uint64.new(12_345)
    memo = Memo.new(memo_id, memo_type)

    # operations
    operations = build_operations()

    ext = TransactionExt.new(Void.new(), 0)

    Transaction.new(
      source_account,
      fee,
      seq_num,
      preconditions,
      memo,
      operations,
      ext
    )
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
    |> Enum.map(fn op -> Operation.new(op, source_account) end)
    |> OperationList100.new()
  end
end
