defmodule Stellar.XDR.UInt64Test do
  use ExUnit.Case

  alias Stellar.XDR.UInt64

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

    test "decode_xdr/2", %{uint64: uint64, binary: binary} do
      {:ok, {^uint64, ^binary}} = UInt64.decode_xdr(binary <> binary)
    end

    test "decode_xdr!/2", %{uint64: uint64, binary: binary} do
      {^uint64, ""} = UInt64.decode_xdr!(binary)
    end
  end
end
