defmodule StellarBase.XDR.SCHostFnErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCHostFnErrorCode

  describe "SCHostFnErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :HOST_FN_UNEXPECTED_HOST_FUNCTION_ACTION,
        default_identifier: :HOST_FN_UNKNOWN_ERROR,
        xdr_type: SCHostFnErrorCode.new(:HOST_FN_UNEXPECTED_HOST_FUNCTION_ACTION)
      }
    end

    test "new/1", %{identifier: type} do
      %SCHostFnErrorCode{identifier: ^type} = SCHostFnErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCHostFnErrorCode{identifier: ^type} = SCHostFnErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCHostFnErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCHostFnErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCHostFnErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCHostFnErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCHostFnErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCHostFnErrorCode.encode_xdr(%SCHostFnErrorCode{identifier: :HOST_TEST})
    end
  end
end
