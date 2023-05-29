defmodule StellarBase.XDR.ScMetaKindTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCMetaKind

  describe "SCMetaKind" do
    setup do
      identifier = :SC_META_V0
      sc_meta_kind = SCMetaKind.new(identifier)

      %{
        identifier: identifier,
        sc_meta_kind: sc_meta_kind,
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{identifier: identifier} do
      %SCMetaKind{identifier: ^identifier} = SCMetaKind.new(identifier)
    end

    test "encode_xdr/1", %{sc_meta_kind: sc_meta_kind, binary: binary} do
      {:ok, ^binary} = SCMetaKind.encode_xdr(sc_meta_kind)
    end

    test "encode_xdr!/1", %{sc_meta_kind: sc_meta_kind, binary: binary} do
      ^binary = SCMetaKind.encode_xdr!(sc_meta_kind)
    end

    test "decode_xdr/2", %{sc_meta_kind: sc_meta_kind, binary: binary} do
      {:ok, {^sc_meta_kind, ""}} = SCMetaKind.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCMetaKind.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_meta_kind: sc_meta_kind, binary: binary} do
      {^sc_meta_kind, ^binary} = SCMetaKind.decode_xdr!(binary <> binary)
    end
  end
end
