defmodule StellarBase.XDR.SCEnvMetaEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCEnvMetaEntry,
    SCEnvMetaKind,
    UInt64
  }

  describe "SCEnvMetaEntry" do
    setup do
      meta_entry_kind = SCEnvMetaKind.new(:SC_ENV_META_KIND_INTERFACE_VERSION)
      entry = UInt64.new(3312)

      %{
        entry: entry,
        meta_entry_kind: meta_entry_kind,
        sc_env_meta_entry: SCEnvMetaEntry.new(entry, meta_entry_kind),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 240>>
      }
    end

    test "new/1", %{entry: entry, meta_entry_kind: meta_entry_kind} do
      %SCEnvMetaEntry{entry: ^entry, type: ^meta_entry_kind} =
        SCEnvMetaEntry.new(entry, meta_entry_kind)
    end

    test "encode_xdr/1", %{sc_env_meta_entry: sc_env_meta_entry, binary: binary} do
      {:ok, ^binary} = SCEnvMetaEntry.encode_xdr(sc_env_meta_entry)
    end

    test "encode_xdr/1 with an invalid meta_entry_kind", %{entry: entry} do
      meta_entry_kind = SCEnvMetaKind.new(:NEW_ADDRESS)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     entry
                     |> SCEnvMetaEntry.new(meta_entry_kind)
                     |> SCEnvMetaEntry.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{sc_env_meta_entry: sc_env_meta_entry, binary: binary} do
      ^binary = SCEnvMetaEntry.encode_xdr!(sc_env_meta_entry)
    end

    test "decode_xdr/2", %{sc_env_meta_entry: sc_env_meta_entry, binary: binary} do
      {:ok, {^sc_env_meta_entry, ""}} = SCEnvMetaEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCEnvMetaEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_env_meta_entry: sc_env_meta_entry, binary: binary} do
      {^sc_env_meta_entry, ^binary} = SCEnvMetaEntry.decode_xdr!(binary <> binary)
    end
  end
end
