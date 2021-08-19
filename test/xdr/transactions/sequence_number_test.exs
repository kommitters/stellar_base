defmodule Stellar.XDR.SequenceNumberTest do
  use ExUnit.Case

  alias Stellar.XDR.SequenceNumber

  describe "SequenceNumber" do
    setup do
      %{
        sequence_number: SequenceNumber.new(1234),
        binary: <<0, 0, 0, 0, 0, 0, 4, 210>>
      }
    end

    test "new/1" do
      %SequenceNumber{sequence_number: 1234} = SequenceNumber.new(1234)
    end

    test "encode_xdr/1", %{sequence_number: sequence_number, binary: binary} do
      {:ok, ^binary} = SequenceNumber.encode_xdr(sequence_number)
    end

    test "encode_xdr/1 a non-integer value" do
      {:error, :not_integer} =
        "hello"
        |> SequenceNumber.new()
        |> SequenceNumber.encode_xdr()
    end

    test "encode_xdr!/1", %{sequence_number: sequence_number, binary: binary} do
      ^binary = SequenceNumber.encode_xdr!(sequence_number)
    end

    test "decode_xdr/2", %{sequence_number: sequence_number, binary: binary} do
      {:ok, {^sequence_number, ""}} = SequenceNumber.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SequenceNumber.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{sequence_number: sequence_number, binary: binary} do
      {^sequence_number, ^binary} = SequenceNumber.decode_xdr!(binary <> binary)
    end
  end
end
