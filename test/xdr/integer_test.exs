defmodule Stellar.XDR.IntegerTest do
  use ExUnit.Case

  alias Stellar.XDR.{Int32, Int64, UInt32, UInt64, UInt256}

  describe "Int32" do
    setup do
      %{
        int: 1234,
        binary: <<0, 0, 4, 210>>
      }
    end

    test "new/1", %{int: int} do
      %Int32{datum: ^int} = Int32.new(int)
    end

    test "encode_xdr/1", %{int: int, binary: binary} do
      {:ok, ^binary} = Int32.encode_xdr(int)
    end

    test "encode_xdr!/1", %{int: int, binary: binary} do
      ^binary = Int32.encode_xdr!(int)
    end

    test "decode_xdr/1", %{int: int, binary: binary} do
      {:ok, {%Int32{datum: ^int}, ""}} = Int32.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{int: int, binary: binary} do
      {%Int32{datum: ^int}, ^binary} = Int32.decode_xdr!(binary <> binary)
    end

    test "non-integer encode" do
      {:error, :not_integer} = Int32.encode_xdr("1234")
    end

    test "non-32bit integer" do
      {:error, :exceed_upper_limit} = Int32.encode_xdr(12_343_838_387)
    end
  end

  describe "Int64" do
    setup do
      %{
        int: 123_456_789,
        binary: <<0, 0, 0, 0, 7, 91, 205, 21>>
      }
    end

    test "new/1", %{int: int} do
      %Int64{datum: ^int} = Int64.new(int)
    end

    test "encode_xdr/1", %{int: int, binary: binary} do
      {:ok, ^binary} = Int64.encode_xdr(int)
    end

    test "encode_xdr!/1", %{int: int, binary: binary} do
      ^binary = Int64.encode_xdr!(int)
    end

    test "decode_xdr/1", %{int: int, binary: binary} do
      {:ok, {%Int64{datum: ^int}, ""}} = Int64.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{int: int, binary: binary} do
      {%Int64{datum: ^int}, ^binary} = Int64.decode_xdr!(binary <> binary)
    end
  end

  describe "UInt32" do
    setup do
      %{
        int: 4_294_967_295,
        binary: <<255, 255, 255, 255>>
      }
    end

    test "new/1", %{int: int} do
      %UInt32{datum: ^int} = UInt32.new(int)
    end

    test "encode_xdr/1", %{int: int, binary: binary} do
      {:ok, ^binary} = UInt32.encode_xdr(int)
    end

    test "encode_xdr!/1", %{int: int, binary: binary} do
      ^binary = UInt32.encode_xdr!(int)
    end

    test "decode_xdr/1", %{int: int, binary: binary} do
      {:ok, {%UInt32{datum: ^int}, ""}} = UInt32.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{int: int, binary: binary} do
      {%UInt32{datum: ^int}, ^binary} = UInt32.decode_xdr!(binary <> binary)
    end

    test "non-uinteger encode" do
      {:error, :not_integer} = UInt32.encode_xdr("1234")
    end

    test "negative integer" do
      {:error, :exceed_lower_limit} = UInt32.encode_xdr(-20)
    end
  end

  describe "UInt64" do
    setup do
      %{
        int: 18_446_744_073_709_551_615,
        binary: <<255, 255, 255, 255, 255, 255, 255, 255>>
      }
    end

    test "new/1", %{int: int} do
      %UInt64{datum: ^int} = UInt64.new(int)
    end

    test "encode_xdr/1", %{int: int, binary: binary} do
      {:ok, ^binary} = UInt64.encode_xdr(int)
    end

    test "encode_xdr!/1", %{int: int, binary: binary} do
      ^binary = UInt64.encode_xdr!(int)
    end

    test "decode_xdr/1", %{int: int, binary: binary} do
      {:ok, {%UInt64{datum: ^int}, ^binary}} = UInt64.decode_xdr(binary <> binary)
    end

    test "decode_xdr!/1", %{int: int, binary: binary} do
      {%UInt64{datum: ^int}, ""} = UInt64.decode_xdr!(binary)
    end
  end

  describe "UInt256" do
    setup do
      %{
        int:
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>,
        binary:
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/1", %{int: int} do
      %UInt256{datum: ^int} = UInt256.new(int)
    end

    test "encode_xdr/1", %{int: int, binary: binary} do
      {:ok, ^binary} = UInt256.encode_xdr(int)
    end

    test "encode_xdr!/1", %{int: int, binary: binary} do
      ^binary = UInt256.encode_xdr!(int)
    end

    test "decode_xdr/1", %{int: int, binary: binary} do
      {:ok, {%UInt256{datum: ^int}, ^binary}} = UInt256.decode_xdr(binary <> binary)
    end

    test "decode_xdr!/1", %{int: int, binary: binary} do
      {%UInt256{datum: ^int}, ""} = UInt256.decode_xdr!(binary)
    end
  end
end
