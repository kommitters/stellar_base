defmodule StellarBase.XDR.ContractIDPublicKeyTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractIDPublicKeyType

  describe "ContractIDPublicKeyType" do
    setup do
      %{
        binary: <<0, 0, 0, 1>>,
        identifier: :CONTRACT_ID_PUBLIC_KEY_ED25519,
        default_identifier: :CONTRACT_ID_PUBLIC_KEY_SOURCE_ACCOUNT,
        xdr_type: ContractIDPublicKeyType.new(:CONTRACT_ID_PUBLIC_KEY_ED25519)
      }
    end

    test "new/1", %{identifier: type} do
      %ContractIDPublicKeyType{identifier: ^type} = ContractIDPublicKeyType.new(type)
    end

    test "new/1 with default value", %{default_identifier: type} do
      %ContractIDPublicKeyType{identifier: ^type} = ContractIDPublicKeyType.new()
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, binary: binary} do
      {:ok, ^binary} = ContractIDPublicKeyType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, binary: binary} do
      ^binary = ContractIDPublicKeyType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, binary: binary} do
      {:ok, {^xdr_type, ""}} = ContractIDPublicKeyType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractIDPublicKeyType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, binary: binary} do
      {^xdr_type, ^binary} = ContractIDPublicKeyType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        ContractIDPublicKeyType.encode_xdr(%ContractIDPublicKeyType{identifier: :SCV_TEST})
    end
  end
end
