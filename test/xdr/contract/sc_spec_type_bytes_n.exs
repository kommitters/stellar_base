defmodule StellarBase.XDR.SCSpecTypeBytesNTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCMapEntry, SCVal, SCValType, Int64}

  describe "SCMapEntry" do
    setup do
      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_U63))
      val = SCVal.new(Int64.new(2), SCValType.new(:SCV_U63))

      %{
        key: key,
        val: val,
        scmap_entry: SCMapEntry.new(key, val),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{key: key, val: val} do
      %SCMapEntry{key: ^key, val: ^val} = SCMapEntry.new(key, val)
    end

    test "encode_xdr/1", %{scmap_entry: scmap_entry, binary: binary} do
      {:ok, ^binary} = SCMapEntry.encode_xdr(scmap_entry)
    end

    test "encode_xdr!/1", %{scmap_entry: scmap_entry, binary: binary} do
      ^binary = SCMapEntry.encode_xdr!(scmap_entry)
    end

    test "decode_xdr/2", %{scmap_entry: scmap_entry, binary: binary} do
      {:ok, {^scmap_entry, ""}} = SCMapEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCMapEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{scmap_entry: scmap_entry, binary: binary} do
      {^scmap_entry, ^binary} = SCMapEntry.decode_xdr!(binary <> binary)
    end
  end
end
