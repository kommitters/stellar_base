defmodule StellarBase.XDR.CreateContractSourceTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.CreateContractSourceType

  describe "CreateContractSourceType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :CONTRACT_SOURCE_INSTALLED,
        default_identifier: :CONTRACT_SOURCE_REF,
        xdr_type: CreateContractSourceType.new(:CONTRACT_SOURCE_INSTALLED)
      }
    end

    test "new/1", %{identifier: type} do
      %CreateContractSourceType{identifier: ^type} = CreateContractSourceType.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %CreateContractSourceType{identifier: ^type} = CreateContractSourceType.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = CreateContractSourceType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = CreateContractSourceType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = CreateContractSourceType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreateContractSourceType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = CreateContractSourceType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        CreateContractSourceType.encode_xdr(%CreateContractSourceType{identifier: :SCV_TEST})
    end
  end
end
