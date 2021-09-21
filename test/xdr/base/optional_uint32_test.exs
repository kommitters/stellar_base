defmodule Stellar.XDR.OptionalUInt32Test do
  use ExUnit.Case

  alias Stellar.XDR.{UInt32, OptionalUInt32}

  describe "OptionalUInt32" do
    setup do
      uint32 = UInt32.new(1234)

      %{
        optional_uint32: OptionalUInt32.new(uint32),
        empty_uint32: OptionalUInt32.new(nil),
        binary: <<0, 0, 0, 1, 0, 0, 4, 210>>
      }
    end

    test "new/1", %{optional_uint32: optional_uint32} do
      %OptionalUInt32{datum: ^optional_uint32} = OptionalUInt32.new(optional_uint32)
    end

    test "new/1 no uint32 opted" do
      %OptionalUInt32{datum: nil} = OptionalUInt32.new(nil)
    end

    test "encode_xdr/1", %{optional_uint32: optional_uint32, binary: binary} do
      {:ok, ^binary} = OptionalUInt32.encode_xdr(optional_uint32)
    end

    test "encode_xdr/1 no uint32 opted", %{empty_uint32: empty_uint32} do
      {:ok, <<0, 0, 0, 0>>} = OptionalUInt32.encode_xdr(empty_uint32)
    end

    test "encode_xdr!/1", %{optional_uint32: optional_uint32, binary: binary} do
      ^binary = OptionalUInt32.encode_xdr!(optional_uint32)
    end

    test "decode_xdr/2", %{optional_uint32: optional_uint32, binary: binary} do
      {:ok, {^optional_uint32, ""}} = OptionalUInt32.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalUInt32.decode_xdr(1234)
    end

    test "decode_xdr/2 when uint32 is not opted" do
      {:ok, {%OptionalUInt32{datum: nil}, ""}} = OptionalUInt32.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_uint32: optional_uint32, binary: binary} do
      {^optional_uint32, ^binary} = OptionalUInt32.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when uint32 is not opted" do
      {%OptionalUInt32{datum: nil}, ""} = OptionalUInt32.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
