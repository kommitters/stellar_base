defmodule StellarBaseXdr.Transactions.OptionalSequenceNumberTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SequenceNumber, OptionalSequenceNumber}

  describe "OptionalSequenceNumber" do
    setup do
      sequence_number = SequenceNumber.new(12345)

      %{
        sequence_number: sequence_number,
        optional_sequence_number: OptionalSequenceNumber.new(sequence_number),
        binary: <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 48, 57>>
      }
    end

    test "new/1", %{sequence_number: sequence_number} do
      %OptionalSequenceNumber{sequence_number: ^sequence_number} =
        OptionalSequenceNumber.new(sequence_number)
    end

    test "encode_xdr/1", %{optional_sequence_number: optional_sequence_number, binary: binary} do
      {:ok, ^binary} = OptionalSequenceNumber.encode_xdr(optional_sequence_number)
    end

    test "encode_xdr!/1", %{optional_sequence_number: optional_sequence_number, binary: binary} do
      ^binary = OptionalSequenceNumber.encode_xdr!(optional_sequence_number)
    end

    test "decode_xdr/2", %{optional_sequence_number: optional_sequence_number, binary: binary} do
      {:ok, {^optional_sequence_number, ""}} = OptionalSequenceNumber.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalSequenceNumber.decode_xdr(1234)
    end

    test "decode_xdr/2 when sequence_number is not opted" do
      no_sequence_number = <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>

      {:ok,
       {%OptionalSequenceNumber{sequence_number: nil},
        <<0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>}} =
        OptionalSequenceNumber.decode_xdr(no_sequence_number)
    end

    test "decode_xdr!/2", %{optional_sequence_number: optional_sequence_number, binary: binary} do
      {^optional_sequence_number, ^binary} = OptionalSequenceNumber.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when sequence_number is not opted" do
      no_sequence_number = <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>

      {%OptionalSequenceNumber{sequence_number: nil},
       <<0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>} =
        OptionalSequenceNumber.decode_xdr!(no_sequence_number)
    end
  end
end
