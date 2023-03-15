defmodule StellarBase.XDR.SCSymbolTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCSymbol

  describe "SCSymbol" do
    setup do
      %{
        sc_symbol: SCSymbol.new("Hello"),
        binary: <<0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0>>
      }
    end

    test "new/1" do
      %SCSymbol{value: "Hello"} = SCSymbol.new("Hello")
    end

    test "encode_xdr/1", %{sc_symbol: sc_symbol, binary: binary} do
      {:ok, ^binary} = SCSymbol.encode_xdr(sc_symbol)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> SCSymbol.new()
        |> SCSymbol.encode_xdr()
    end

    test "encode_xdr/1 an invalid string lenght" do
      {:error, :invalid_length} =
        "Hello There"
        |> SCSymbol.new()
        |> SCSymbol.encode_xdr()
    end

    test "encode_xdr!/1", %{sc_symbol: sc_symbol, binary: binary} do
      ^binary = SCSymbol.encode_xdr!(sc_symbol)
    end

    test "encode_xdr!/1 a string longer than 10-bytes" do
      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     "Hello this is a very very very large test"
                     |> SCSymbol.new()
                     |> SCSymbol.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{sc_symbol: sc_symbol, binary: binary} do
      {:ok, {^sc_symbol, ""}} = SCSymbol.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSymbol.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     SCSymbol.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{sc_symbol: sc_symbol, binary: binary} do
      {^sc_symbol, ^binary} = SCSymbol.decode_xdr!(binary <> binary)
    end
  end
end
