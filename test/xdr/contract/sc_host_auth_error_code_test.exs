defmodule StellarBase.XDR.SCHostAuthErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCHostAuthErrorCode

  describe "SCHostAuthErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :HOST_AUTH_NONCE_ERROR,
        default_identifier: :HOST_AUTH_UNKNOWN_ERROR,
        xdr_type: SCHostAuthErrorCode.new(:HOST_AUTH_NONCE_ERROR)
      }
    end

    test "new/1", %{identifier: type} do
      %SCHostAuthErrorCode{identifier: ^type} = SCHostAuthErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCHostAuthErrorCode{identifier: ^type} = SCHostAuthErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCHostAuthErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCHostAuthErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCHostAuthErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCHostAuthErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCHostAuthErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCHostAuthErrorCode.encode_xdr(%SCHostAuthErrorCode{identifier: :HOST_TEST})
    end
end
