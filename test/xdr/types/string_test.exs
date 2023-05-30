defmodule StellarBase.XDR.StringTest do
  use ExUnit.Case

  alias StellarBase.XDR.String

  describe "String" do
    setup do
      %{
        string: String.new("Hello"),
        binary: <<0, 0, 0, 5, 72, 101, 108, 108, 111, 0, 0, 0>>
      }
    end

    test "new/1" do
      %String{value: "Hello"} = String.new("Hello")
    end

    test "encode_xdr/1", %{string: string, binary: binary} do
      {:ok, ^binary} = String.encode_xdr(string)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String.new()
        |> String.encode_xdr()
    end

    test "encode_xdr!/1", %{string: string, binary: binary} do
      ^binary = String.encode_xdr!(string)
    end

    test "decode_xdr/2", %{string: string, binary: binary} do
      {:ok, {^string, ""}} = String.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = String.decode_xdr(123)
    end

    test "decode_xdr!/2", %{string: string, binary: binary} do
      {^string, ^binary} = String.decode_xdr!(binary <> binary)
    end
  end
end
