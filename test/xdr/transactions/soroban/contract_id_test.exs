defmodule StellarBase.XDR.ContractIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Asset,
    ContractIDPublicKey,
    ContractPublicKey,
    ContractIDPublicKeyType,
    ContractIDType,
    ContractID,
    UInt256,
    PublicKey,
    AccountID,
    AssetType,
    AssetCode4,
    AlphaNum4,
    Signature,
    Ed25519KeyWithSignature,
    PublicKeyType
  }

  alias StellarBase.StrKey

  describe "ContractID" do
    setup do
      ## Asset
      key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      issuer =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(key_type)
        |> AccountID.new()

      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      alpha_num4 = "BTCN" |> AssetCode4.new() |> AlphaNum4.new(issuer)

      asset = Asset.new(alpha_num4, asset_type)

      ## ContractPublicKey
      key =
        "GCVILYTXYXYHZIBYEF4BSLATAP3CPZMW23NE6DUL7I6LCCDUNFBQFAVR"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

      signature = Signature.new("SAPVVUQ2G755KGQOOY5A3AGTMWCCQQTJMGSXAUKMFT45OFCL7NCSTRWI")
      ed25519_key_with_signature = Ed25519KeyWithSignature.new(signature, key)
      contract_id_public_key_type = ContractIDPublicKeyType.new(:CONTRACT_ID_PUBLIC_KEY_ED25519)

      contract_id_public_key =
        ContractIDPublicKey.new(ed25519_key_with_signature, contract_id_public_key_type)

      contract_public_key = ContractPublicKey.new(contract_id_public_key, key)

      discriminants = [
        %{
          contract_id_type: ContractIDType.new(:CONTRACT_ID_FROM_PUBLIC_KEY),
          contract_id: contract_public_key,
          binary:
            <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 56, 83, 65, 80, 86, 86, 85, 81, 50, 71, 55, 53, 53,
              75, 71, 81, 79, 79, 89, 53, 65, 51, 65, 71, 84, 77, 87, 67, 67, 81, 81, 84, 74, 77,
              71, 83, 88, 65, 85, 75, 77, 70, 84, 52, 53, 79, 70, 67, 76, 55, 78, 67, 83, 84, 82,
              87, 73, 170, 133, 226, 119, 197, 240, 124, 160, 56, 33, 120, 25, 44, 19, 3, 246, 39,
              229, 150, 214, 218, 79, 14, 139, 250, 60, 177, 8, 116, 105, 67, 2, 170, 133, 226,
              119, 197, 240, 124, 160, 56, 33, 120, 25, 44, 19, 3, 246, 39, 229, 150, 214, 218,
              79, 14, 139, 250, 60, 177, 8, 116, 105, 67, 2>>
        },
        %{
          contract_id_type: ContractIDType.new(:CONTRACT_ID_FROM_ASSET),
          contract_id: asset,
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85,
              29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117,
              165, 56, 34, 114, 247, 89, 216>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/1", %{discriminants: discriminants} do
      for %{contract_id_type: contract_id_type, contract_id: contract_id} <-
            discriminants do
        %ContractID{contract_id: ^contract_id, type: ^contract_id_type} =
          ContractID.new(contract_id, contract_id_type)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{
            contract_id: contract_id,
            contract_id_type: contract_id_type,
            binary: binary
          } <- discriminants do
        xdr = ContractID.new(contract_id, contract_id_type)
        {:ok, ^binary} = ContractID.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{
            contract_id: contract_id,
            contract_id_type: contract_id_type,
            binary: binary
          } <- discriminants do
        xdr = ContractID.new(contract_id, contract_id_type)
        ^binary = ContractID.encode_xdr!(xdr)
      end
    end

    test "encode_xdr/1 with an invalid type", %{discriminants: [contract_id | _rest]} do
      contract_id_type = ContractIDType.new(:NEW_ADDRESS)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     contract_id
                     |> ContractID.new(contract_id_type)
                     |> ContractID.encode_xdr()
                   end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{
            contract_id: contract_id,
            contract_id_type: contract_id_type,
            binary: binary
          } <- discriminants do
        xdr = ContractID.new(contract_id, contract_id_type)
        {:ok, {^xdr, ""}} = ContractID.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{
            contract_id: contract_id,
            contract_id_type: contract_id_type,
            binary: binary
          } <- discriminants do
        xdr = ContractID.new(contract_id, contract_id_type)
        {^xdr, ""} = ContractID.decode_xdr!(binary)
      end
    end
  end
end
