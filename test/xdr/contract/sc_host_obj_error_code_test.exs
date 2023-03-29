defmodule StellarBase.XDR.SCHostObjErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCHostObjErrorCode

  describe "SCHostObjErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :HOST_OBJECT_UNKNOWN_REFERENCE,
        default_identifier: :HOST_OBJECT_UNKNOWN_ERROR,
        xdr_type: SCHostObjErrorCode.new(:HOST_OBJECT_UNKNOWN_REFERENCE)
      }
    end

    test "new/1", %{identifier: type} do
      %SCHostObjErrorCode{identifier: ^type} = SCHostObjErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCHostObjErrorCode{identifier: ^type} = SCHostObjErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCHostObjErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCHostObjErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCHostObjErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCHostObjErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCHostObjErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCHostObjErrorCode.encode_xdr(%SCHostObjErrorCode{identifier: :HOST_TEST})
    end
  end
end
