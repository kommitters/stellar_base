defmodule StellarBase.XDR.String60Test do
  use ExUnit.Case

  alias StellarBase.XDR.String60

  describe "String60" do
    setup do
      %{
        string60: String60.new("Hello there"),
        binary: <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1" do
      %String60{value: "Hello there"} = String60.new("Hello there")
    end

    test "encode_xdr/1", %{string60: string60, binary: binary} do
      {:ok, ^binary} = String60.encode_xdr(string60)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String60.new()
        |> String60.encode_xdr()
    end

    test "encode_xdr!/1", %{string60: string60, binary: binary} do
      ^binary = String60.encode_xdr!(string60)
    end

    test "encode_xdr!/1 a string longer than 60-bytes" do
      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     "XNmdeP1Qrap2PZAkG78pdMtcKY98VROKieOduLP45fBiqyucOwR77nDI0D6pkuudab"
                     |> String60.new()
                     |> String60.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{string60: string60, binary: binary} do
      {:ok, {^string60, ""}} = String60.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = String60.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     String60.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{string60: string60, binary: binary} do
      {^string60, ^binary} = String60.decode_xdr!(binary <> binary)
    end
  end
end
