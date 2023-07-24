defmodule StellarBase.XDR.ContractIDPreimageTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractIDPreimageType

  describe "ContractIDPreimageType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :CONTRACT_ID_PREIMAGE_FROM_ASSET,
        default_identifier: :CONTRACT_ID_PREIMAGE_FROM_ADDRESS,
        xdr_type: ContractIDPreimageType.new(:CONTRACT_ID_PREIMAGE_FROM_ASSET)
      }
    end

    test "new/1", %{identifier: type} do
      %ContractIDPreimageType{identifier: ^type} = ContractIDPreimageType.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %ContractIDPreimageType{identifier: ^type} = ContractIDPreimageType.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = ContractIDPreimageType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = ContractIDPreimageType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = ContractIDPreimageType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractIDPreimageType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = ContractIDPreimageType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        ContractIDPreimageType.encode_xdr(%ContractIDPreimageType{identifier: :SCV_TEST})
    end
  end
end
