defmodule StellarBase.XDR.SCStatusTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCStatusType

  describe "SCStatusType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :SST_UNKNOWN_ERROR,
        default_identifier: :SST_OK,
        xdr_type: SCStatusType.new(:SST_UNKNOWN_ERROR)
      }
    end

    test "new/1", %{identifier: type} do
      %SCStatusType{identifier: ^type} = SCStatusType.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %SCStatusType{identifier: ^type} = SCStatusType.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = SCStatusType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = SCStatusType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = SCStatusType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCStatusType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = SCStatusType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} = SCStatusType.encode_xdr(%SCStatusType{identifier: :SST_TEST})
    end
  end
end
