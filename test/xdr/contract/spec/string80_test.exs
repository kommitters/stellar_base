defmodule StellarBase.XDR.String80Test do
  use ExUnit.Case

  alias StellarBase.XDR.String80

  describe "String80" do
    setup do
      %{
        string80: String80.new("Hello there"),
        binary: <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1" do
      %String80{value: "Hello there"} = String80.new("Hello there")
    end

    test "encode_xdr/1", %{string80: string80, binary: binary} do
      {:ok, ^binary} = String80.encode_xdr(string80)
    end

    test "encode_xdr/1 a non-string value" do
      {:error, :not_bitstring} =
        123
        |> String80.new()
        |> String80.encode_xdr()
    end

    test "encode_xdr!/1", %{string80: string80, binary: binary} do
      ^binary = String80.encode_xdr!(string80)
    end

    test "encode_xdr!/1 a string longer than 80-bytes" do
      assert_raise XDR.StringError,
                   "The length of the string exceeds the max length allowed",
                   fn ->
                     "XNmdeP1Qrap2PZAkG78pdMtcKY98VROKieOduLP45fBiqyucOwR77nDI0D6pkuudabXNmdeP1Qrap2PZAkG78pdMtcKY98VROKieOduLP45fBiqyucOwR77nDI0D6pkuudab"
                     |> String80.new()
                     |> String80.encode_xdr!()
                   end
    end

    test "decode_xdr/2", %{string80: string80, binary: binary} do
      {:ok, {^string80, ""}} = String80.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = String80.decode_xdr(123)
    end

    test "decode_xdr/2 an invalid binary" do
      assert_raise XDR.VariableOpaqueError,
                   "The XDR has an invalid length, it must be less than byte-size of the rest",
                   fn ->
                     String80.decode_xdr(<<0, 0, 4, 210>>)
                   end
    end

    test "decode_xdr!/2", %{string80: string80, binary: binary} do
      {^string80, ^binary} = String80.decode_xdr!(binary <> binary)
    end
  end
end
