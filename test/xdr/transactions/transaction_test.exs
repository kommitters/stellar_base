defmodule StellarBase.XDR.TransactionTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    TransactionExt,
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
    Uint32,
    Uint64,
    Void
  }

  alias StellarBase.XDR.Transaction

  describe "Transaction" do
    setup do
      precondition_type = PreconditionType.new(:PRECOND_TIME)

      source_account =
        create_muxed_account("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      fee = Uint32.new(100)
      seq_num = SequenceNumber.new(Int64.new(12_345_678))

      # preconditions
      min_time = TimePoint.new(Uint64.new(123))
      max_time = TimePoint.new(Uint64.new(321))

      preconditions =
        min_time
        |> TimeBounds.new(max_time)
        |> Preconditions.new(precondition_type)

      # memo
      memo_type = MemoType.new(:MEMO_ID)
      memo_id = Uint64.new(12_345)
      memo = Memo.new(memo_id, memo_type)

      # operations
      operations = build_operations()

      ext = TransactionExt.new(Void.new(), 0)

      %{
        source_account: source_account,
        fee: fee,
        seq_num: seq_num,
        preconditions: preconditions,
        memo: memo,
        operations: operations,
        ext: ext,
        transaction:
          Transaction.new(
            source_account,
            fee,
            seq_num,
            preconditions,
            memo,
            operations,
            ext
          ),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0,
            100, 0, 0, 0, 0, 0, 188, 97, 78, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0,
            0, 1, 65, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 48, 57, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0,
            155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135,
            171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0,
            0, 108, 108, 200, 144, 232, 101, 96, 6, 227, 152, 210, 30, 178, 125, 14, 180, 37, 218,
            186, 125, 140, 233, 21, 108, 175, 188, 190, 189, 62, 75, 154, 219, 0, 0, 0, 1, 66, 84,
            67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205,
            198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0,
            0, 0, 1, 42, 5, 242, 0, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29,
            207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165,
            56, 34, 114, 247, 89, 216, 0, 0, 0, 19, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48,
            50, 49, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6, 227, 152, 210, 30, 178, 125, 14,
            180, 37, 218, 186, 125, 140, 233, 21, 108, 175, 188, 190, 189, 62, 75, 154, 219, 0, 0,
            0, 0, 59, 154, 202, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      source_account: source_account,
      fee: fee,
      seq_num: seq_num,
      memo: memo,
      preconditions: preconditions,
      operations: operations,
      ext: ext
    } do
      %Transaction{
        source_account: ^source_account,
        operations: ^operations,
        memo: ^memo
      } = Transaction.new(source_account, fee, seq_num, preconditions, memo, operations, ext)
    end

    test "encode_xdr/1", %{transaction: transaction, binary: binary} do
      {:ok, ^binary} = Transaction.encode_xdr(transaction)
    end

    test "encode_xdr!/1", %{transaction: transaction, binary: binary} do
      ^binary = Transaction.encode_xdr!(transaction)
    end

    test "decode_xdr/2", %{transaction: transaction, binary: binary} do
      {:ok, {^transaction, ""}} = Transaction.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Transaction.decode_xdr(123)
    end

    test "decode_xdr!/2", %{transaction: transaction, binary: binary} do
      {^transaction, ^binary} = Transaction.decode_xdr!(binary <> binary)
    end
  end

  @spec build_operations() :: OperationList100.t()
  defp build_operations do
    source_account =
      "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
      |> create_muxed_account()
      |> OptionalMuxedAccount.new()

    destination = create_muxed_account("GBWGZSEQ5BSWABXDTDJB5MT5B22CLWV2PWGOSFLMV66L5PJ6JONNWG24")

    asset1 =
      create_asset(:alpha_num4,
        code: "BTCN",
        issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      )

    asset2 =
      create_asset(:alpha_num12,
        code: "BTCNEW2021",
        issuer: "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      )

    payment_operation = payment_op_body(destination, asset1, Int64.new(5_000_000_000))
    clawback_operation = clawback_op_body(asset2, destination, Int64.new(1_000_000_000))

    [payment_operation, clawback_operation]
    |> Enum.map(fn op -> Operation.new(source_account, op) end)
    |> OperationList100.new()
  end
end
