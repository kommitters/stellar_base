defmodule StellarBase.XDR.ContractPublicKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractIDPublicKeyType,
    Ed25519KeyWithSignature,
    ContractIDPublicKey,
    ContractPublicKey,
    Signature,
    UInt256
  }

  describe "ContractPublicKey" do
    setup do
      salt =
        UInt256.new(
          <<72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108,
            108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0>>
        )

      signature = Signature.new("SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI")
      ed25519_key_with_signature = Ed25519KeyWithSignature.new(signature, salt)

      contract_id_public_key_type = ContractIDPublicKeyType.new(:CONTRACT_ID_PUBLIC_KEY_ED25519)

      key_source =
        ContractIDPublicKey.new(ed25519_key_with_signature, contract_id_public_key_type)

      %{
        key_source: key_source,
        salt: salt,
        contract_public_key: ContractPublicKey.new(key_source, salt),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81,
            79, 79, 89, 53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88,
            65, 85, 75, 77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73, 72,
            101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108, 108,
            111, 32, 119, 111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108, 108, 111, 32, 119,
            111, 114, 108, 100, 0, 21, 0, 1, 0, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108,
            100, 0, 21, 0, 1, 0>>
      }
    end

    test "new/1", %{key_source: key_source, salt: salt} do
      %ContractPublicKey{key_source: ^key_source, salt: ^salt} =
        ContractPublicKey.new(key_source, salt)
    end

    test "encode_xdr/1", %{contract_public_key: contract_public_key, binary: binary} do
      {:ok, ^binary} = ContractPublicKey.encode_xdr(contract_public_key)
    end

    test "encode_xdr!/1", %{contract_public_key: contract_public_key, binary: binary} do
      ^binary = ContractPublicKey.encode_xdr!(contract_public_key)
    end

    test "decode_xdr/2", %{contract_public_key: contract_public_key, binary: binary} do
      {:ok, {^contract_public_key, ""}} = ContractPublicKey.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractPublicKey.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_public_key: contract_public_key, binary: binary} do
      {^contract_public_key, ^binary} = ContractPublicKey.decode_xdr!(binary <> binary)
    end
  end
end
