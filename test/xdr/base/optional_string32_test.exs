defmodule StellarBase.XDR.OptionalString32Test do
  use ExUnit.Case

  alias StellarBase.XDR.{String32, OptionalString32}

  describe "OptionalString32" do
    setup do
      string32 = String32.new("hello there")

      %{
        optional_string32: OptionalString32.new(string32),
        empty_string32: OptionalString32.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 11, 104, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1", %{optional_string32: optional_string32} do
      %OptionalString32{value: ^optional_string32} = OptionalString32.new(optional_string32)
    end

    test "new/1 no String32 opted" do
      %OptionalString32{value: nil} = OptionalString32.new(nil)
    end

    test "encode_xdr/1", %{optional_string32: optional_string32, binary: binary} do
      {:ok, ^binary} = OptionalString32.encode_xdr(optional_string32)
    end

    test "encode_xdr/1 no String32 opted", %{empty_string32: empty_string32} do
      {:ok, <<0, 0, 0, 0>>} = OptionalString32.encode_xdr(empty_string32)
    end

    test "encode_xdr!/1", %{optional_string32: optional_string32, binary: binary} do
      ^binary = OptionalString32.encode_xdr!(optional_string32)
    end

    test "decode_xdr/2", %{optional_string32: optional_string32, binary: binary} do
      {:ok, {^optional_string32, ""}} = OptionalString32.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalString32.decode_xdr(1234)
    end

    test "decode_xdr/2 when String32 is not opted" do
      {:ok, {%OptionalString32{value: nil}, ""}} = OptionalString32.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_string32: optional_string32, binary: binary} do
      {^optional_string32, ^binary} = OptionalString32.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when String32 is not opted" do
      {%OptionalString32{value: nil}, ""} = OptionalString32.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
