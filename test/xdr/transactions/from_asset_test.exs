defmodule StellarBase.XDR.HashIDPreimageFromAssetTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    HashIDPreimageFromAsset,
    Hash,
    Asset,
    AssetCode4,
    AlphaNum4,
    AssetType,
    AccountID,
    PublicKey,
    Uint256,
    PublicKeyType
  }

  alias StellarBase.StrKey

  describe "HashIDPreimageFromAsset" do
    setup do
      network_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      issuer =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(key_type)
        |> AccountID.new()

      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)
      alpha_num4 = "BTCN" |> AssetCode4.new() |> AlphaNum4.new(issuer)

      asset = Asset.new(alpha_num4, asset_type)

      %{
        network_id: network_id,
        asset: asset,
        from_asset: HashIDPreimageFromAsset.new(network_id, asset),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0,
            155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135,
            171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{
      network_id: network_id,
      asset: asset
    } do
      %HashIDPreimageFromAsset{
        network_id: ^network_id,
        asset: ^asset
      } = HashIDPreimageFromAsset.new(network_id, asset)
    end

    test "encode_xdr/1", %{from_asset: from_asset, binary: binary} do
      {:ok, ^binary} = HashIDPreimageFromAsset.encode_xdr(from_asset)
    end

    test "encode_xdr!/1", %{from_asset: from_asset, binary: binary} do
      ^binary = HashIDPreimageFromAsset.encode_xdr!(from_asset)
    end

    test "decode_xdr/2", %{from_asset: from_asset, binary: binary} do
      {:ok, {^from_asset, ""}} = HashIDPreimageFromAsset.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = HashIDPreimageFromAsset.decode_xdr(123)
    end

    test "decode_xdr!/2", %{from_asset: from_asset, binary: binary} do
      {^from_asset, ""} = HashIDPreimageFromAsset.decode_xdr!(binary)
    end
  end
end
