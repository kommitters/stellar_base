defmodule StellarBase.XDR.SCHostStorageErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCHostStorageErrorCode

  describe "SCHostStorageErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :HOST_STORAGE_EXPECT_CONTRACT_DATA,
        default_identifier: :HOST_STORAGE_UNKNOWN_ERROR,
        xdr_type: SCHostStorageErrorCode.new(:HOST_STORAGE_EXPECT_CONTRACT_DATA)
      }
    end

    test "new/1", %{identifier: type} do
      %SCHostStorageErrorCode{identifier: ^type} = SCHostStorageErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCHostStorageErrorCode{identifier: ^type} = SCHostStorageErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCHostStorageErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCHostStorageErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCHostStorageErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCHostStorageErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCHostStorageErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        SCHostStorageErrorCode.encode_xdr(%SCHostStorageErrorCode{identifier: :HOST_TEST})
    end
  end
end
