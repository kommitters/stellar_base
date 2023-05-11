defmodule StellarBase.XDR.OptionalUint32Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Uint32, OptionalUint32}

  describe "OptionalUint32" do
    setup do
      uint32 = Uint32.new(1234)

      %{
        optional_uint32: OptionalUint32.new(uint32),
        empty_uint32: OptionalUint32.new(nil),
        binary: <<0, 0, 0, 1, 0, 0, 4, 210>>
      }
    end

    test "new/1", %{optional_uint32: optional_uint32} do
      %OptionalUint32{uint32: ^optional_uint32} = OptionalUint32.new(optional_uint32)
    end

    test "new/1 no uint32 opted" do
      %OptionalUint32{uint32: nil} = OptionalUint32.new(nil)
    end

    test "encode_xdr/1", %{optional_uint32: optional_uint32, binary: binary} do
      {:ok, ^binary} = OptionalUint32.encode_xdr(optional_uint32)
    end

    test "encode_xdr/1 no uint32 opted", %{empty_uint32: empty_uint32} do
      {:ok, <<0, 0, 0, 0>>} = OptionalUint32.encode_xdr(empty_uint32)
    end

    test "encode_xdr!/1", %{optional_uint32: optional_uint32, binary: binary} do
      ^binary = OptionalUint32.encode_xdr!(optional_uint32)
    end

    test "decode_xdr/2", %{optional_uint32: optional_uint32, binary: binary} do
      {:ok, {^optional_uint32, ""}} = OptionalUint32.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalUint32.decode_xdr(1234)
    end

    test "decode_xdr/2 when uint32 is not opted" do
      {:ok, {%OptionalUint32{uint32: nil}, ""}} = OptionalUint32.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_uint32: optional_uint32, binary: binary} do
      {^optional_uint32, ^binary} = OptionalUint32.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when uint32 is not opted" do
      {%OptionalUint32{uint32: nil}, ""} = OptionalUint32.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
