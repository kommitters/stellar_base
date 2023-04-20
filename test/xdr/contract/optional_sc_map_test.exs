defmodule StellarBase.XDR.OptionalSCMapTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Int64,
    OptionalSCMap,
    SCMap,
    SCMapEntry,
    SCVal,
    SCValType
  }

  describe "OptionalSCMap" do
    setup do
      key1 = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      val1 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      scmap_entry1 = SCMapEntry.new(key1, val1)

      key2 = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      val2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      scmap_entry2 = SCMapEntry.new(key2, val2)

      scmap_entries = [scmap_entry1, scmap_entry2]

      sc_map = SCMap.new(scmap_entries)

      %{
        optional_sc_map: OptionalSCMap.new(sc_map),
        empty_sc_map: OptionalSCMap.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{optional_sc_map: optional_sc_map} do
      %OptionalSCMap{sc_map: ^optional_sc_map} = OptionalSCMap.new(optional_sc_map)
    end

    test "new/1 no sc_map opted" do
      %OptionalSCMap{sc_map: nil} = OptionalSCMap.new(nil)
    end

    test "encode_xdr/1", %{optional_sc_map: optional_sc_map, binary: binary} do
      {:ok, ^binary} = OptionalSCMap.encode_xdr(optional_sc_map)
    end

    test "encode_xdr/1 no sc_map opted", %{empty_sc_map: empty_sc_map} do
      {:ok, <<0, 0, 0, 0>>} = OptionalSCMap.encode_xdr(empty_sc_map)
    end

    test "encode_xdr!/1", %{optional_sc_map: optional_sc_map, binary: binary} do
      ^binary = OptionalSCMap.encode_xdr!(optional_sc_map)
    end

    test "decode_xdr/2", %{optional_sc_map: optional_sc_map, binary: binary} do
      {:ok, {^optional_sc_map, ""}} = OptionalSCMap.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalSCMap.decode_xdr(1234)
    end

    test "decode_xdr/2 when sc_map is not opted" do
      {:ok, {%OptionalSCMap{sc_map: nil}, ""}} = OptionalSCMap.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_sc_map: optional_sc_map, binary: binary} do
      {^optional_sc_map, ^binary} = OptionalSCMap.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when sc_map is not opted" do
      {%OptionalSCMap{sc_map: nil}, ""} = OptionalSCMap.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
