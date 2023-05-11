defmodule StellarBase.XDR.BumpSequenceOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.SequenceNumber
  alias StellarBase.XDR.BumpSequenceOp

  describe "BumpSequenceOp Operation" do
    setup do
      sequence_number = SequenceNumber.new(12_345)

      %{
        bump_to: sequence_number,
        bump_sequence: BumpSequenceOp.new(sequence_number),
        binary: <<0, 0, 0, 0, 0, 0, 48, 57>>
      }
    end

    test "new/1", %{bump_to: bump_to} do
      %BumpSequenceOp{bump_to: ^bump_to} = BumpSequenceOp.new(bump_to)
    end

    test "encode_xdr/1", %{bump_sequence: bump_sequence, binary: binary} do
      {:ok, ^binary} = BumpSequenceOp.encode_xdr(bump_sequence)
    end

    test "encode_xdr!/1", %{bump_sequence: bump_sequence, binary: binary} do
      ^binary = BumpSequenceOp.encode_xdr!(bump_sequence)
    end

    test "decode_xdr/2", %{bump_sequence: bump_sequence, binary: binary} do
      {:ok, {^bump_sequence, ""}} = BumpSequenceOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = BumpSequenceOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{bump_sequence: bump_sequence, binary: binary} do
      {^bump_sequence, ^binary} = BumpSequenceOp.decode_xdr!(binary <> binary)
    end
  end
end
