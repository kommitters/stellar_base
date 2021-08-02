defmodule Stellar.XDR.IntegerTest do
  use ExUnit.Case

  alias Stellar.XDR.{Int32, Int64, UInt32, UInt64, UInt256}

  describe "Int32" do
    setup do
      %{
        int32: Int32.new(1234),
        binary: <<0, 0, 4, 210>>
      }
    end

    test "new/1" do
      %Int32{datum: 1234} = Int32.new(1234)
    end

    test "encode_xdr/1", %{int32: int32, binary: binary} do
      {:ok, ^binary} = Int32.encode_xdr(int32)
    end

    test "encode_xdr!/1", %{int32: int32, binary: binary} do
      ^binary = Int32.encode_xdr!(int32)
    end

    test "decode_xdr/1", %{int32: int32, binary: binary} do
      {:ok, {^int32, ""}} = Int32.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{int32: int32, binary: binary} do
      {^int32, ^binary} = Int32.decode_xdr!(binary <> binary)
    end

    test "non-integer encode" do
      {:error, :not_integer} = Int32.encode_xdr(%Int32{datum: "1234"})
    end

    test "non-32bit integer" do
      {:error, :exceed_upper_limit} = Int32.encode_xdr(%Int32{datum: 12_343_838_387})
    end
  end

  describe "Int64" do
    setup do
      %{
        int64: Int64.new(123_456_789),
        binary: <<0, 0, 0, 0, 7, 91, 205, 21>>
      }
    end

    test "new/1" do
      %Int64{datum: 123_456_789} = Int64.new(123_456_789)
    end

    test "encode_xdr/1", %{int64: int64, binary: binary} do
      {:ok, ^binary} = Int64.encode_xdr(int64)
    end

    test "encode_xdr!/1", %{int64: int64, binary: binary} do
      ^binary = Int64.encode_xdr!(int64)
    end

    test "decode_xdr/1", %{int64: int64, binary: binary} do
      {:ok, {^int64, ""}} = Int64.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{int64: int64, binary: binary} do
      {^int64, ^binary} = Int64.decode_xdr!(binary <> binary)
    end
  end

  describe "UInt32" do
    setup do
      %{
        uint32: UInt32.new(4_294_967_295),
        binary: <<255, 255, 255, 255>>
      }
    end

    test "new/1" do
      %UInt32{datum: 4_294_967_295} = UInt32.new(4_294_967_295)
    end

    test "encode_xdr/1", %{uint32: uint32, binary: binary} do
      {:ok, ^binary} = UInt32.encode_xdr(uint32)
    end

    test "encode_xdr!/1", %{uint32: uint32, binary: binary} do
      ^binary = UInt32.encode_xdr!(uint32)
    end

    test "decode_xdr/1", %{uint32: uint32, binary: binary} do
      {:ok, {^uint32, ""}} = UInt32.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{uint32: uint32, binary: binary} do
      {^uint32, ^binary} = UInt32.decode_xdr!(binary <> binary)
    end

    test "non-uinteger encode" do
      {:error, :not_integer} = UInt32.encode_xdr(%UInt32{datum: "1234"})
    end

    test "negative integer" do
      {:error, :exceed_lower_limit} = UInt32.encode_xdr(%UInt32{datum: -20})
    end
  end

  describe "UInt64" do
    setup do
      %{
        uint64: UInt64.new(18_446_744_073_709_551_615),
        binary: <<255, 255, 255, 255, 255, 255, 255, 255>>
      }
    end

    test "new/1" do
      %UInt64{datum: 18_446_744_073_709_551_615} = UInt64.new(18_446_744_073_709_551_615)
    end

    test "encode_xdr/1", %{uint64: uint64, binary: binary} do
      {:ok, ^binary} = UInt64.encode_xdr(uint64)
    end

    test "encode_xdr!/1", %{uint64: uint64, binary: binary} do
      ^binary = UInt64.encode_xdr!(uint64)
    end

    test "decode_xdr/1", %{uint64: uint64, binary: binary} do
      {:ok, {^uint64, ^binary}} = UInt64.decode_xdr(binary <> binary)
    end

    test "decode_xdr!/1", %{uint64: uint64, binary: binary} do
      {^uint64, ""} = UInt64.decode_xdr!(binary)
    end
  end

  describe "UInt256" do
    setup do
      %{
        uint256:
          UInt256.new(
            <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
              108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
          ),
        binary:
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/1", %{binary: binary} do
      %UInt256{datum: ^binary} = UInt256.new(binary)
    end

    test "encode_xdr/1", %{uint256: uint256, binary: binary} do
      {:ok, ^binary} = UInt256.encode_xdr(uint256)
    end

    test "encode_xdr!/1", %{uint256: uint256, binary: binary} do
      ^binary = UInt256.encode_xdr!(uint256)
    end

    test "decode_xdr/1", %{uint256: uint256, binary: binary} do
      {:ok, {^uint256, ^binary}} = UInt256.decode_xdr(binary <> binary)
    end

    test "decode_xdr!/1", %{uint256: uint256, binary: binary} do
      {^uint256, ""} = UInt256.decode_xdr!(binary)
    end
  end
end
