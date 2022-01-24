defmodule StellarBase.XDR.OperationIDTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{OperationID, SequenceNumber, UInt32}

  describe "OperationID" do
    setup do
      source_account =
        create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")

      seq_number = SequenceNumber.new(123_456)
      op_num = UInt32.new(123_456)

      %{
        source_account: source_account,
        seq_number: seq_number,
        op_num: op_num,
        operation_id: OperationID.new(source_account, seq_number, op_num),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 1, 226, 64, 0, 1, 226, 64>>
      }
    end

    test "new/3", %{source_account: source_account, seq_number: seq_number, op_num: op_num} do
      %OperationID{source_account: ^source_account, sequence_number: ^seq_number, op_num: ^op_num} =
        OperationID.new(source_account, seq_number, op_num)
    end

    test "encode_xdr/1", %{operation_id: operation_id, binary: binary} do
      {:ok, ^binary} = OperationID.encode_xdr(operation_id)
    end

    test "encode_xdr!/1", %{operation_id: operation_id, binary: binary} do
      ^binary = OperationID.encode_xdr!(operation_id)
    end

    test "decode_xdr/2", %{operation_id: operation_id, binary: binary} do
      {:ok, {^operation_id, ""}} = OperationID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{operation_id: operation_id, binary: binary} do
      {^operation_id, ""} = OperationID.decode_xdr!(binary)
    end
  end
end
