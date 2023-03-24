defmodule StellarBase.XDR.ContractIDPublicKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractIDPublicKeyType,
    Ed25519KeyWithSignature,
    Void,
    ContractIDPublicKey,
    UInt256,
    Signature
  }

  alias StellarBase.StrKey

  describe "ContractIDPublicKey" do
    setup do
      key =
        "GCVILYTXYXYHZIBYEF4BSLATAP3CPZMW23NE6DUL7I6LCCDUNFBQFAVR"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

      signature = Signature.new("SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI")
      ed25519_key_with_signature = Ed25519KeyWithSignature.new(signature, key)

      discriminants = [
        %{
          contract_key_type: ContractIDPublicKeyType.new(:CONTRACT_ID_PUBLIC_KEY_SOURCE_ACCOUNT),
          contract_key: Void.new(),
          binary: <<0, 0, 0, 0>>
        },
        %{
          contract_key_type: ContractIDPublicKeyType.new(:CONTRACT_ID_PUBLIC_KEY_ED25519),
          contract_key: ed25519_key_with_signature,
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53, 75, 71, 81,
              79, 79, 89, 53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77, 71, 83, 88,
              65, 85, 75, 77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82, 87, 73, 170,
              133, 226, 119, 197, 240, 124, 160, 56, 33, 120, 25, 44, 19, 3, 246, 39, 229, 150,
              214, 218, 79, 14, 139, 250, 60, 177, 8, 116, 105, 67, 2>>
        }
      ]

      %{
        discriminants: discriminants
      }
    end

    test "new/1", %{discriminants: discriminants} do
      for %{contract_key_type: contract_key_type, contract_key: contract_key} <-
            discriminants do
        %ContractIDPublicKey{contract_id_public_key: ^contract_key, type: ^contract_key_type} =
          ContractIDPublicKey.new(contract_key, contract_key_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{contract_key_type: contract_key_type, contract_key: contract_key, binary: binary} <-
            discriminants do
        {:ok, ^binary} =
          contract_key
          |> ContractIDPublicKey.new(contract_key_type)
          |> ContractIDPublicKey.encode_xdr()
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{contract_key_type: contract_key_type, contract_key: contract_key, binary: binary} <-
            discriminants do
        ^binary =
          contract_key
          |> ContractIDPublicKey.new(contract_key_type)
          |> ContractIDPublicKey.encode_xdr!()
      end
    end

    test "encode_xdr!/1 with a default value" do
      contract_key_type = ContractIDPublicKeyType.new()
      contract_key = Void.new()
      result = ContractIDPublicKey.new(contract_key, contract_key_type)

      <<0, 0, 0, 0>> = ContractIDPublicKey.encode_xdr!(result)
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{contract_key_type: contract_key_type, contract_key: contract_key, binary: binary} <-
            discriminants do
        contract_id_public_key = ContractIDPublicKey.new(contract_key, contract_key_type)

        {:ok, {^contract_id_public_key, ""}} = ContractIDPublicKey.decode_xdr(binary)
      end
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{contract_key_type: contract_key_type, contract_key: contract_key, binary: binary} <-
            discriminants do
        contract_id_public_key = ContractIDPublicKey.new(contract_key, contract_key_type)

        {^contract_id_public_key, ""} = ContractIDPublicKey.decode_xdr!(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractIDPublicKey.decode_xdr(123)
    end
  end
end
