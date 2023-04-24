defmodule StellarBase.XDR.SCStringTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCString

  describe "SCString" do
    setup do
      %{
        sc_symbol: SCString.new("Hello"),
        binary: <<0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0>>
      }
    end

    test "new/1" do
      %SCString{value: "Hello"} = SCString.new("Hello")
    end

    test "encode_xdr/1", %{sc_symbol: sc_symbol, binary: binary} do
      {:ok, ^binary} = SCString.encode_xdr(sc_symbol)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> SCString.new()
        |> SCString.encode_xdr()
    end

    test "encode_xdr/1 an invalid string lenght" do
      bits = 256_001 * 8
      large_string = <<64::size(bits)>>

      {:error, :invalid_length} =
        large_string
        |> SCString.new()
        |> SCString.encode_xdr()
    end

    test "encode_xdr!/1", %{sc_symbol: sc_symbol, binary: binary} do
      ^binary = SCString.encode_xdr!(sc_symbol)
    end

    test "encode_xdr!/1 a string longer than 256000-bytes" do
      bits = 256_001 * 8
      large_string = <<64::size(bits)>>

      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     large_string
                     |> SCString.new()
                     |> SCString.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{sc_symbol: sc_symbol, binary: binary} do
      {:ok, {^sc_symbol, ""}} = SCString.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCString.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     SCString.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{sc_symbol: sc_symbol, binary: binary} do
      {^sc_symbol, ^binary} = SCString.decode_xdr!(binary <> binary)
    end
  end
end
