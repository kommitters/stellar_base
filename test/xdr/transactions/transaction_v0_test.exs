defmodule StellarBase.XDR.TransactionV0Test do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    Ext,
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
    TransactionV0,
    UInt32,
    UInt64,
    UInt256
  }

  alias StellarBase.Ed25519.PublicKey, as: Ed25519

  describe "TransactionV0" do
    setup do
      source_account_ed25519 =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> Ed25519.decode!()
        |> UInt256.new()

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

      ext = Ext.new()

      %{
        source_account: source_account_ed25519,
        fee: fee,
        seq_num: seq_num,
        time_bounds: op_time_bounds,
        memo: memo,
        operations: operations,
        ext: ext,
        transaction_v0:
          TransactionV0.new(
            source_account_ed25519,
            fee,
            seq_num,
            op_time_bounds,
            memo,
            operations,
            ext
          ),
        binary:
          <<155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135,
            171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 100, 0, 0,
            0, 0, 0, 188, 97, 78, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65,
            0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 48, 57, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142,
            186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45,
            179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1, 0, 0, 0, 0, 108, 108,
            200, 144, 232, 101, 96, 6, 227, 152, 210, 30, 178, 125, 14, 180, 37, 218, 186, 125,
            140, 233, 21, 108, 175, 188, 190, 189, 62, 75, 154, 219, 0, 0, 0, 1, 66, 84, 67, 78,
            0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0,
            1, 42, 5, 242, 0, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207,
            158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56,
            34, 114, 247, 89, 216, 0, 0, 0, 19, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 50,
            49, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 108, 108, 200, 144, 232, 101, 96, 6, 227, 152, 210, 30, 178, 125, 14, 180,
            37, 218, 186, 125, 140, 233, 21, 108, 175, 188, 190, 189, 62, 75, 154, 219, 0, 0, 0,
            0, 59, 154, 202, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      source_account: source_account,
      fee: fee,
      seq_num: seq_num,
      memo: memo,
      time_bounds: time_bounds,
      operations: operations,
      ext: ext
    } do
      %TransactionV0{
        source_account_ed25519: ^source_account,
        operations: ^operations,
        memo: ^memo
      } = TransactionV0.new(source_account, fee, seq_num, time_bounds, memo, operations, ext)
    end

    test "encode_xdr/1", %{transaction_v0: transaction_v0, binary: binary} do
      {:ok, ^binary} = TransactionV0.encode_xdr(transaction_v0)
    end

    test "encode_xdr!/1", %{transaction_v0: transaction_v0, binary: binary} do
      ^binary = TransactionV0.encode_xdr!(transaction_v0)
    end

    test "decode_xdr/2", %{transaction_v0: transaction_v0, binary: binary} do
      {:ok, {^transaction_v0, ""}} = TransactionV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TransactionV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{transaction_v0: transaction_v0, binary: binary} do
      {^transaction_v0, ^binary} = TransactionV0.decode_xdr!(binary <> binary)
    end
  end

  @spec build_operations() :: Operations.t()
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
    |> Operations.new()
  end
end
