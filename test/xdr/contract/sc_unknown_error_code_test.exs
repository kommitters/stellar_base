defmodule StellarBase.XDR.SCUnknownErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCUnknownErrorCode

  describe "SCUnknownErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :UNKNOWN_ERROR_XDR,
        default_identifier: :UNKNOWN_ERROR_GENERAL,
        xdr_type: SCUnknownErrorCode.new(:UNKNOWN_ERROR_XDR)
      }
    end

    test "new/1", %{identifier: type} do
      %SCUnknownErrorCode{identifier: ^type} = SCUnknownErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCUnknownErrorCode{identifier: ^type} = SCUnknownErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCUnknownErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCUnknownErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCUnknownErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCUnknownErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCUnknownErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCUnknownErrorCode.encode_xdr(%SCUnknownErrorCode{identifier: :UNKNOWN_ERROR_TEST})
    end
  end
end
