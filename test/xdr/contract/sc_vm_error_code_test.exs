defmodule StellarBase.XDR.SCVmErrorCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCVmErrorCode

  describe "SCVmErrorCode" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :VM_VALIDATION,
        default_identifier: :VM_UNKNOWN,
        xdr_type: SCVmErrorCode.new(:VM_VALIDATION)
      }
    end

    test "new/1", %{identifier: type} do
      %SCVmErrorCode{identifier: ^type} = SCVmErrorCode.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCVmErrorCode{identifier: ^type} = SCVmErrorCode.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCVmErrorCode.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCVmErrorCode.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCVmErrorCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCVmErrorCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCVmErrorCode.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} = SCVmErrorCode.encode_xdr(%SCVmErrorCode{identifier: :VM_TEST})
    end
  end
end
