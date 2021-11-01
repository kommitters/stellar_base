defmodule Stellar.XDR.TransactionSignaturePayloadTest do
  use ExUnit.Case

  import Stellar.Test.Utils

  alias Stellar.XDR.{
    EnvelopeType,
    Ext,
    Hash,
    Int64,
    Memo,
    MemoType,
    OptionalTimeBounds,
    OptionalMuxedAccount,
    Operation,
    Operations,
    SequenceNumber,
    TimeBounds,
    TimePoint,
    Transaction,
    TransactionSignaturePayload,
    UInt32,
    UInt64
  }

  alias Stellar.XDR.TransactionSignaturePayloadTaggedTransaction, as: TaggedTransaction

  describe "Transaction" do
    setup do
      # Seq number
      fee = UInt32.new(100)
      seq_num = SequenceNumber.new(12_345_678)

      # time bounds
      min_time = TimePoint.new(123)
      max_time = TimePoint.new(321)
      time_bounds = TimeBounds.new(min_time, max_time)
      op_time_bounds = OptionalTimeBounds.new(time_bounds)

      # memo
      memo_type = MemoType.new(:MEMO_ID)
      memo_id = UInt64.new(12_345)
      memo = Memo.new(memo_id, memo_type)

      # operations
      operations = build_operations()

      # ext
      ext = Ext.new()

      tagged_tx =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> create_muxed_account()
        |> Transaction.new(fee, seq_num, op_time_bounds, memo, operations, ext)
        |> TaggedTransaction.new(EnvelopeType.new(:ENVELOPE_TYPE_TX))

      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        network_id: network_id,
        tagged_tx: tagged_tx,
        signature_payload: TransactionSignaturePayload.new(network_id, tagged_tx),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186,
            248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179,
            214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 100, 0, 0, 0, 0, 0, 188, 97,
            78, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65, 0, 0, 0, 2, 0, 0,
            0, 0, 0, 0, 48, 57, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56,
            85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 108, 108, 200, 144, 232,
            101, 96, 6, 227, 152, 210, 30, 178, 125, 14, 180, 37, 218, 186, 125, 140, 233, 21,
            108, 175, 188, 190, 189, 62, 75, 154, 219, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0,
            114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173,
            152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 1, 42, 5, 242,
            0, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247,
            67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 19, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27,
            186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76,
            25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6,
            227, 152, 210, 30, 178, 125, 14, 180, 37, 218, 186, 125, 140, 233, 21, 108, 175, 188,
            190, 189, 62, 75, 154, 219, 0, 0, 0, 0, 59, 154, 202, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{network_id: network_id, tagged_tx: tagged_tx} do
      %TransactionSignaturePayload{network_id: ^network_id, tagged_transaction: ^tagged_tx} =
        TransactionSignaturePayload.new(network_id, tagged_tx)
    end

    test "encode_xdr/1", %{signature_payload: signature_payload, binary: binary} do
      {:ok, ^binary} = TransactionSignaturePayload.encode_xdr(signature_payload)
    end

    test "encode_xdr!/1", %{signature_payload: signature_payload, binary: binary} do
      ^binary = TransactionSignaturePayload.encode_xdr!(signature_payload)
    end

    test "decode_xdr/2", %{signature_payload: signature_payload, binary: binary} do
      {:ok, {^signature_payload, ""}} = TransactionSignaturePayload.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TransactionSignaturePayload.decode_xdr(123)
    end

    test "decode_xdr!/2", %{signature_payload: signature_payload, binary: binary} do
      {^signature_payload, ^binary} = TransactionSignaturePayload.decode_xdr!(binary <> binary)
    end
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
    |> Enum.map(fn op -> Operation.new(source_account, op) end)
    |> Operations.new()
  end
end
