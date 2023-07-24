defmodule StellarBase.XDR.HashIDPreimageContractIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    ContractIDPreimage,
    ContractIDPreimageType,
    Hash,
    HashIDPreimageContractID,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "HashIDPreimageContractID" do
    setup do
      key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      issuer =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(key_type)
        |> AccountID.new()

      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      alpha_num4 =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)

      asset = Asset.new(alpha_num4, asset_type)

      network_id =
        Hash.new(
          <<163, 161, 198, 167, 130, 134, 113, 62, 41, 190, 14, 151, 133, 103, 15, 168, 56, 209,
            57, 23, 205, 142, 174, 180, 163, 87, 159, 241, 222, 188, 127, 213>>
        )

      contract_id_preimage =
        ContractIDPreimage.new(
          asset,
          ContractIDPreimageType.new(:CONTRACT_ID_PREIMAGE_FROM_ASSET)
        )

      %{
        network_id: network_id,
        contract_id_preimage: contract_id_preimage,
        hash_id_preimage_contract_id:
          HashIDPreimageContractID.new(network_id, contract_id_preimage),
        binary:
          <<163, 161, 198, 167, 130, 134, 113, 62, 41, 190, 14, 151, 133, 103, 15, 168, 56, 209,
            57, 23, 205, 142, 174, 180, 163, 87, 159, 241, 222, 188, 127, 213, 0, 0, 0, 1, 0, 0,
            0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164,
            247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114,
            247, 89, 216>>
      }
    end

    test "new/3", %{network_id: network_id, contract_id_preimage: contract_id_preimage} do
      %HashIDPreimageContractID{
        network_id: ^network_id,
        contract_id_preimage: ^contract_id_preimage
      } =
        HashIDPreimageContractID.new(
          network_id,
          contract_id_preimage
        )
    end

    test "encode_xdr/1", %{
      hash_id_preimage_contract_id: hash_id_preimage_contract_id,
      binary: binary
    } do
      {:ok, ^binary} = HashIDPreimageContractID.encode_xdr(hash_id_preimage_contract_id)
    end

    test "encode_xdr!/1", %{
      hash_id_preimage_contract_id: hash_id_preimage_contract_id,
      binary: binary
    } do
      ^binary = HashIDPreimageContractID.encode_xdr!(hash_id_preimage_contract_id)
    end

    test "decode_xdr/2", %{
      hash_id_preimage_contract_id: hash_id_preimage_contract_id,
      binary: binary
    } do
      {:ok, {^hash_id_preimage_contract_id, ""}} = HashIDPreimageContractID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimageContractID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      hash_id_preimage_contract_id: hash_id_preimage_contract_id,
      binary: binary
    } do
      {^hash_id_preimage_contract_id, ""} = HashIDPreimageContractID.decode_xdr!(binary)
    end
  end
end
