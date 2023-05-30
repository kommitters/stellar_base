defmodule StellarBase.XDR.SCMetaEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCMetaEntry, SCMetaKind, SCMetaV0, String, SCMetaKind}

  describe "SCMetaEntry" do
    setup do
      key = String.new("key")
      val = String.new("val")
      value = SCMetaV0.new(key, val)
      type = SCMetaKind.new(:SC_META_V0)

      %{
        value: value,
        type: type,
        sc_meta_entry: SCMetaEntry.new(value, type),
        binary: <<0, 0, 0, 0, 0, 0, 0, 3, 107, 101, 121, 0, 0, 0, 0, 3, 118, 97, 108, 0>>
      }
    end

    test "new/1", %{value: value, type: type} do
      %SCMetaEntry{value: ^value, type: ^type} = SCMetaEntry.new(value, type)
    end

    test "encode_xdr/1", %{sc_meta_entry: sc_meta_entry, binary: binary} do
      {:ok, ^binary} = SCMetaEntry.encode_xdr(sc_meta_entry)
    end

    test "encode_xdr/1 with an invalid type", %{value: value} do
      value_type = SCMetaKind.new(:INVALID_TYPE)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     value
                     |> SCMetaEntry.new(value_type)
                     |> SCMetaEntry.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{sc_meta_entry: sc_meta_entry, binary: binary} do
      ^binary = SCMetaEntry.encode_xdr!(sc_meta_entry)
    end

    test "decode_xdr/2", %{sc_meta_entry: sc_meta_entry, binary: binary} do
      {:ok, {^sc_meta_entry, ""}} = SCMetaEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCMetaEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_meta_entry: sc_meta_entry, binary: binary} do
      {^sc_meta_entry, ^binary} = SCMetaEntry.decode_xdr!(binary <> binary)
    end
  end
end
