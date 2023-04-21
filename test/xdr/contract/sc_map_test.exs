defmodule StellarBase.XDR.SCMapTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Int64,
    SCMap,
    SCMapEntry,
    SCVal,
    SCValType
  }

  describe "SCMap" do
    setup do
      key1 = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      val1 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      scmap_entry1 = SCMapEntry.new(key1, val1)

      key2 = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      val2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      scmap_entry2 = SCMapEntry.new(key2, val2)

      scmap_entries = [scmap_entry1, scmap_entry2]

      %{
        scmap_entries: scmap_entries,
        scmap: SCMap.new(scmap_entries),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{scmap_entries: scmap_entries} do
      %SCMap{scmap_entries: ^scmap_entries} = SCMap.new(scmap_entries)
    end

    test "encode_xdr/1", %{scmap: scmap, binary: binary} do
      {:ok, ^binary} = SCMap.encode_xdr(scmap)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> SCMap.new()
        |> SCMap.encode_xdr()
    end

    test "encode_xdr!/1", %{scmap: scmap, binary: binary} do
      ^binary = SCMap.encode_xdr!(scmap)
    end

    test "decode_xdr/2", %{scmap: scmap, binary: binary} do
      {:ok, {^scmap, ""}} = SCMap.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCMap.decode_xdr(123)
    end

    test "decode_xdr!/2", %{scmap: scmap, binary: binary} do
      {^scmap, ^binary} = SCMap.decode_xdr!(binary <> binary)
    end
  end
end
