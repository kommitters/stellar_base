defmodule Stellar.XDR.String28Test do
  use ExUnit.Case

  alias Stellar.XDR.String28

  describe "String28" do
    setup do
      %{
        string28: String28.new("Hello there"),
        binary: <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1" do
      %String28{value: "Hello there"} = String28.new("Hello there")
    end

    test "encode_xdr/1", %{string28: string28, binary: binary} do
      {:ok, ^binary} = String28.encode_xdr(string28)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String28.new()
        |> String28.encode_xdr()
    end

    test "encode_xdr!/1", %{string28: string28, binary: binary} do
      ^binary = String28.encode_xdr!(string28)
    end

    test "encode_xdr!/1 a string longer than 28-bytes" do
      assert_raise XDR.Error.String,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     "Hello this is a very large test"
                     |> String28.new()
                     |> String28.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{string28: string28, binary: binary} do
      {:ok, {^string28, ""}} = String28.decode_xdr(binary)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.Error.VariableOpaque,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     String28.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{string28: string28, binary: binary} do
      {^string28, ^binary} = String28.decode_xdr!(binary <> binary)
    end
  end
end
