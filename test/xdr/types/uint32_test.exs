defmodule StellarBase.XDR.Uint32Test do
  use ExUnit.Case

  alias StellarBase.XDR.Uint32

  describe "Uint32" do
    setup do
      %{
        uint32: Uint32.new(4_294_967_295),
        binary: <<255, 255, 255, 255>>
      }
    end

    test "new/1" do
      %Uint32{datum: 4_294_967_295} = Uint32.new(4_294_967_295)
    end

    test "encode_xdr/1", %{uint32: uint32, binary: binary} do
      {:ok, ^binary} = Uint32.encode_xdr(uint32)
    end

    test "encode_xdr/1 with a not a uinteger" do
      {:error, :not_integer} = Uint32.encode_xdr(%Uint32{datum: "1234"})
    end

    test "encode_xdr/1 with a negative integer" do
      {:error, :exceed_lower_limit} = Uint32.encode_xdr(%Uint32{datum: -20})
    end

    test "encode_xdr!/1", %{uint32: uint32, binary: binary} do
      ^binary = Uint32.encode_xdr!(uint32)
    end

    test "decode_xdr/2", %{uint32: uint32, binary: binary} do
      {:ok, {^uint32, ""}} = Uint32.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Uint32.decode_xdr(123)
    end

    test "decode_xdr!/2", %{uint32: uint32, binary: binary} do
      {^uint32, ^binary} = Uint32.decode_xdr!(binary <> binary)
    end
  end
end
