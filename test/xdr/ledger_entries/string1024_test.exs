defmodule StellarBase.XDR.String1024Test do
  use ExUnit.Case

  alias StellarBase.XDR.String1024

  describe "String1024" do
    setup do
      %{
        string1024: String1024.new("Hello there"),
        binary: <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1" do
      %String1024{value: "Hello there"} = String1024.new("Hello there")
    end

    test "encode_xdr/1", %{string1024: string1024, binary: binary} do
      {:ok, ^binary} = String1024.encode_xdr(string1024)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String1024.new()
        |> String1024.encode_xdr()
    end

    test "encode_xdr!/1", %{string1024: string1024, binary: binary} do
      ^binary = String1024.encode_xdr!(string1024)
    end

    test "encode_xdr!/1 a string longer than 1024-bytes" do
      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     <<84::size(1025 * 8)>>
                     |> String1024.new()
                     |> String1024.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{string1024: string1024, binary: binary} do
      {:ok, {^string1024, ""}} = String1024.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = String1024.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     String1024.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{string1024: string1024, binary: binary} do
      {^string1024, ^binary} = String1024.decode_xdr!(binary <> binary)
    end
  end
end
