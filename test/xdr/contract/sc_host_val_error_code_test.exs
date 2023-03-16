defmodule StellarBase.XDR.SCHostValErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCHostValErrorCode

  describe "SCHostValErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :HOST_VALUE_RESERVED_TAG_VALUE,
        default_identifier: :HOST_VALUE_UNKNOWN_ERROR,
        xdr_type: SCHostValErrorCode.new(:HOST_VALUE_RESERVED_TAG_VALUE)
      }
    end

    test "new/1", %{identifier: type} do
      %SCHostValErrorCode{identifier: ^type} = SCHostValErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCHostValErrorCode{identifier: ^type} = SCHostValErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCHostValErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCHostValErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCHostValErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCHostValErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCHostValErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCHostValErrorCode.encode_xdr(%SCHostValErrorCode{identifier: :HOST_TEST})
    end
  end
end
