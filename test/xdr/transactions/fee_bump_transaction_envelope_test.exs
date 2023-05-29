defmodule StellarBase.XDR.FeeBumpTransactionEnvelopeTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    EnvelopeType,
    Ext,
    FeeBumpInnerTx,
    FeeBumpTransaction,
    FeeBumpTransactionEnvelope,
    Int64,
    Memo,
    MemoType,
    OptionalMuxedAccount,
    Operation,
    Operations,
    Preconditions,
    PreconditionType,
    SequenceNumber,
    TimeBounds,
    TimePoint,
    Transaction,
    TransactionExt,
    TransactionV1Envelope,
    UInt32,
    UInt64,
    Void
  }

  describe "FeeBumpTransactionEnvelope" do
    setup do
      tx = build_fee_bump_tx()

      signatures =
        build_decorated_signatures([
          "SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI",
          "SBVNQLIDS7V3NAOYTATT26QL7Y4S6C2X4YN7PN5FIJ6JUAN4UV4YPLUY"
        ])

      %{
        tx: tx,
        signatures: signatures,
        tx_envelope: FeeBumpTransactionEnvelope.new(tx, signatures),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 1, 134, 160, 0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 100, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0, 0, 1, 0, 0, 0, 0,
            0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 48, 57, 0, 0, 0,
            2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247,
            67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 1, 0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6, 227, 152, 210, 30,
            178, 125, 14, 180, 37, 218, 186, 125, 140, 233, 21, 108, 175, 188, 190, 189, 62, 75,
            154, 219, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186,
            154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25,
            212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 1, 42, 5, 242, 0, 0, 0, 0, 1, 0, 0, 0, 0,
            155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135,
            171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 19, 0, 0, 0,
            1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149,
            154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2,
            227, 119, 0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6, 227, 152, 210, 30, 178,
            125, 14, 180, 37, 218, 186, 125, 140, 233, 21, 108, 175, 188, 190, 189, 62, 75, 154,
            219, 0, 0, 0, 0, 59, 154, 202, 0, 0, 0, 0, 0, 0, 0, 0, 2, 84, 82, 87, 73, 0, 0, 0, 56,
            83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81, 79, 79, 89, 53, 65, 51,
            65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88, 65, 85, 75, 77, 70, 84,
            52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73, 80, 76, 85, 89, 0, 0, 0, 56,
            83, 66, 86, 78, 81, 76, 73, 68, 83, 55, 86, 51, 78, 65, 79, 89, 84, 65, 84, 84, 50,
            54, 81, 76, 55, 89, 52, 83, 54, 67, 50, 88, 52, 89, 78, 55, 80, 78, 53, 70, 73, 74,
            54, 74, 85, 65, 78, 52, 85, 86, 52, 89, 80, 76, 85, 89, 0, 0, 0, 0, 0, 0, 0, 2, 84,
            82, 87, 73, 0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81,
            79, 79, 89, 53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88,
            65, 85, 75, 77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73, 80,
            76, 85, 89, 0, 0, 0, 56, 83, 66, 86, 78, 81, 76, 73, 68, 83, 55, 86, 51, 78, 65, 79,
            89, 84, 65, 84, 84, 50, 54, 81, 76, 55, 89, 52, 83, 54, 67, 50, 88, 52, 89, 78, 55,
            80, 78, 53, 70, 73, 74, 54, 74, 85, 65, 78, 52, 85, 86, 52, 89, 80, 76, 85, 89>>
      }
    end

    test "new/1", %{tx: tx, signatures: signatures} do
      %FeeBumpTransactionEnvelope{tx: ^tx, signatures: ^signatures} =
        FeeBumpTransactionEnvelope.new(tx, signatures)
    end

    test "encode_xdr/1", %{tx_envelope: tx_envelope, binary: binary} do
      {:ok, ^binary} = FeeBumpTransactionEnvelope.encode_xdr(tx_envelope)
    end

    test "encode_xdr!/1", %{tx_envelope: tx_envelope, binary: binary} do
      ^binary = FeeBumpTransactionEnvelope.encode_xdr!(tx_envelope)
    end

    test "decode_xdr/2", %{tx_envelope: tx_envelope, binary: binary} do
      {:ok, {^tx_envelope, ""}} = FeeBumpTransactionEnvelope.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = FeeBumpTransactionEnvelope.decode_xdr(123)
    end

    test "decode_xdr!/2", %{tx_envelope: tx_envelope, binary: binary} do
      {^tx_envelope, ^binary} = FeeBumpTransactionEnvelope.decode_xdr!(binary <> binary)
    end
  end

  @spec build_fee_bump_tx() :: FeeBumpInnerTx.t()
  defp build_fee_bump_tx do
    envelope_type = EnvelopeType.new(:ENVELOPE_TYPE_TX)

    signatures =
      build_decorated_signatures([
        "SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI",
        "SBVNQLIDS7V3NAOYTATT26QL7Y4S6C2X4YN7PN5FIJ6JUAN4UV4YPLUY"
      ])

    fee_source = create_muxed_account("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

    fee = Int64.new(100_000)

    inner_tx =
      build_transaction()
      |> TransactionV1Envelope.new(signatures)
      |> FeeBumpInnerTx.new(envelope_type)

    ext = Ext.new()

    FeeBumpTransaction.new(fee_source, fee, inner_tx, ext)
  end

  @spec build_transaction() :: TransactionV0.t()
  defp build_transaction do
    source_account =
      create_muxed_account("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

    fee = UInt32.new(100)
    seq_num = SequenceNumber.new(12_345_678)

    # preconditions
    min_time = TimePoint.new(123)
    max_time = TimePoint.new(321)
    time_bounds = TimeBounds.new(min_time, max_time)
    precondition_type = PreconditionType.new(:PRECOND_TIME)
    preconditions = Preconditions.new(time_bounds, precondition_type)

    # memo
    memo_type = MemoType.new(:MEMO_ID)
    memo_id = UInt64.new(12_345)
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

  @spec build_operations() :: Operations.t()
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
    |> Operations.new()
  end
end
