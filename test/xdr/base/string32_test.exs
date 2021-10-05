defmodule Stellar.XDR.String32Test do
  use ExUnit.Case

  alias Stellar.XDR.String32

  describe "String32" do
    setup do
      %{
        string32: String32.new("Hello there"),
        binary: <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1" do
      %String32{value: "Hello there"} = String32.new("Hello there")
    end

    test "encode_xdr/1", %{string32: string32, binary: binary} do
      {:ok, ^binary} = String32.encode_xdr(string32)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String32.new()
        |> String32.encode_xdr()
    end

    test "encode_xdr!/1", %{string32: string32, binary: binary} do
      ^binary = String32.encode_xdr!(string32)
    end

    test "encode_xdr!/1 a string longer than 28-bytes" do
      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     "Hello this is a very very very large test"
                     |> String32.new()
                     |> String32.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{string32: string32, binary: binary} do
      {:ok, {^string32, ""}} = String32.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = String32.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     String32.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{string32: string32, binary: binary} do
      {^string32, ^binary} = String32.decode_xdr!(binary <> binary)
    end
  end
end
