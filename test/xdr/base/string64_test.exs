defmodule Stellar.XDR.String64Test do
  use ExUnit.Case

  alias Stellar.XDR.String64

  describe "String64" do
    setup do
      %{
        string64: String64.new("Hello there this is a test"),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0>>
      }
    end

    test "new/1" do
      %String64{value: "Hello there this is a test"} = String64.new("Hello there this is a test")
    end

    test "encode_xdr/1", %{string64: string64, binary: binary} do
      {:ok, ^binary} = String64.encode_xdr(string64)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String64.new()
        |> String64.encode_xdr()
    end

    test "encode_xdr!/1", %{string64: string64, binary: binary} do
      ^binary = String64.encode_xdr!(string64)
    end

    test "encode_xdr!/1 a string longer than 64-bytes" do
      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     "XNmdeP1Qrap2PZAkG78pdMtcKY98VROKieOduLP45fBiqyucOwR77nDI0D6pkuudab"
                     |> String64.new()
                     |> String64.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{string64: string64, binary: binary} do
      {:ok, {^string64, ""}} = String64.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = String64.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     String64.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{string64: string64, binary: binary} do
      {^string64, ^binary} = String64.decode_xdr!(binary <> binary)
    end
  end
end
