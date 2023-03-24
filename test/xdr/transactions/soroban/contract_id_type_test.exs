defmodule StellarBase.XDR.ContractIDTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractIDType

  describe "ContractIDType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :CONTRACT_ID_FROM_ASSET,
        default_identifier: :CONTRACT_ID_FROM_PUBLIC_KEY,
        xdr_type: ContractIDType.new(:CONTRACT_ID_FROM_ASSET)
      }
    end

    test "new/1", %{identifier: type} do
      %ContractIDType{identifier: ^type} = ContractIDType.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %ContractIDType{identifier: ^type} = ContractIDType.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = ContractIDType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = ContractIDType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = ContractIDType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractIDType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = ContractIDType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} = ContractIDType.encode_xdr(%ContractIDType{identifier: :SCV_TEST})
    end
  end
end
