defmodule StellarBase.XDR.HostFunctionTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.HostFunctionType

  describe "HostFunctionType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :HOST_FUNCTION_TYPE_CREATE_CONTRACT,
        default_identifier: :HOST_FUNCTION_TYPE_INVOKE_CONTRACT,
        xdr_type: HostFunctionType.new(:HOST_FUNCTION_TYPE_CREATE_CONTRACT)
      }
    end

    test "new/1", %{identifier: type} do
      %HostFunctionType{identifier: ^type} = HostFunctionType.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %HostFunctionType{identifier: ^type} = HostFunctionType.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = HostFunctionType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = HostFunctionType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = HostFunctionType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HostFunctionType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = HostFunctionType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        HostFunctionType.encode_xdr(%HostFunctionType{identifier: :SCV_TEST})
    end
  end
end
