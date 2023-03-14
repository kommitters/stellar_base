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
      key1 = SCVal.new(Int64.new(1), SCValType.new(:SCV_U63))
      val1 = SCVal.new(Int64.new(2), SCValType.new(:SCV_U63))
      scmap_entry1 = SCMapEntry.new(key1, val1)

      key2 = SCVal.new(Int64.new(1), SCValType.new(:SCV_U63))
      val2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_U63))
      scmap_entry2 = SCMapEntry.new(key2, val2)

      scmap_list = [scmap_entry1, scmap_entry2]

      %{
        scmap_list: scmap_list,
        claimants: SCMap.new(scmap_list),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{scmap_list: scmap_list} do
      %SCMap{claimants: ^scmap_list} = SCMap.new(scmap_list)
    end

    test "encode_xdr/1", %{claimants: claimants, binary: binary} do
      {:ok, ^binary} = SCMap.encode_xdr(claimants)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> SCMap.new()
        |> SCMap.encode_xdr()
    end

    test "encode_xdr!/1", %{claimants: claimants, binary: binary} do
      ^binary = SCMap.encode_xdr!(claimants)
    end

    test "decode_xdr/2", %{claimants: claimants, binary: binary} do
      {:ok, {^claimants, ""}} = SCMap.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCMap.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claimants: claimants, binary: binary} do
      {^claimants, ^binary} = SCMap.decode_xdr!(binary <> binary)
    end
  end
end
