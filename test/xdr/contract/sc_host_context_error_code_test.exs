defmodule StellarBase.XDR.SCHostContextErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCHostContextErrorCode

  describe "SCHostContextErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :HOST_CONTEXT_NO_CONTRACT_RUNNING,
        default_identifier: :HOST_CONTEXT_UNKNOWN_ERROR,
        xdr_type: SCHostContextErrorCode.new(:HOST_CONTEXT_NO_CONTRACT_RUNNING)
      }
    end

    test "new/1", %{identifier: type} do
      %SCHostContextErrorCode{identifier: ^type} = SCHostContextErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCHostContextErrorCode{identifier: ^type} = SCHostContextErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCHostContextErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCHostContextErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCHostContextErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCHostContextErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCHostContextErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCHostContextErrorCode.encode_xdr(%SCHostContextErrorCode{identifier: :HOST_TEST})
    end
  end
end
