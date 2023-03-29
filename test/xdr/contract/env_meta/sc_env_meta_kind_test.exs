defmodule StellarBase.XDR.SCEnvMetaKindTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCEnvMetaKind

  describe "SCEnvMetaKind" do
    setup do
      %{
        binary: <<0, 0, 0, 0>>,
        identifier: :SC_ENV_META_KIND_INTERFACE_VERSION,
        default_identifier: :SC_ENV_META_KIND_INTERFACE_VERSION,
        xdr_type: SCEnvMetaKind.new(:SC_ENV_META_KIND_INTERFACE_VERSION)
      }
    end

    test "new/1", %{identifier: type} do
      %SCEnvMetaKind{identifier: ^type} = SCEnvMetaKind.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCEnvMetaKind{identifier: ^type} = SCEnvMetaKind.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCEnvMetaKind.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCEnvMetaKind.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCEnvMetaKind.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCEnvMetaKind.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCEnvMetaKind.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCEnvMetaKind.encode_xdr(%SCEnvMetaKind{identifier: :SC_ENV_META_KIND_TEST})
    end
  end
end
