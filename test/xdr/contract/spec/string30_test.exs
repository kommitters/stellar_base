defmodule StellarBase.XDR.String30Test do
  use ExUnit.Case

  alias StellarBase.XDR.String30

  describe "String30" do
    setup do
      %{
        string30: String30.new("Hello there"),
        binary: <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1" do
      %String30{value: "Hello there"} = String30.new("Hello there")
    end

    test "encode_xdr/1", %{string30: string30, binary: binary} do
      {:ok, ^binary} = String30.encode_xdr(string30)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String30.new()
        |> String30.encode_xdr()
    end

    test "encode_xdr!/1", %{string30: string30, binary: binary} do
      ^binary = String30.encode_xdr!(string30)
    end

    test "encode_xdr!/1 a string longer than 30-bytes" do
      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     "Hello this is a very large test"
                     |> String30.new()
                     |> String30.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{string30: string30, binary: binary} do
      {:ok, {^string30, ""}} = String30.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = String30.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     String30.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{string30: string30, binary: binary} do
      {^string30, ^binary} = String30.decode_xdr!(binary <> binary)
    end
  end
end
