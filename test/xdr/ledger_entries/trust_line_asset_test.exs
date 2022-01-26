defmodule StellarBase.XDR.TrustLineAssetTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    AlphaNum12,
    AssetCode4,
    AssetCode12,
    AssetType,
    PoolID,
    PublicKey,
    PublicKeyType,
    TrustLineAsset,
    UInt256
  }

  alias StellarBase.StrKey

  setup_all do
    key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

    issuer =
      "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
      |> StrKey.decode!(:ed25519_public_key)
      |> UInt256.new()
      |> PublicKey.new(key_type)
      |> AccountID.new()

    {:ok, %{issuer: issuer}}
  end

  describe "AlphaNum4 Asset" do
    setup %{issuer: issuer} do
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      alpha_num4 =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)

      %{
        alpha_num4: alpha_num4,
        asset_type: asset_type,
        asset: TrustLineAsset.new(alpha_num4, asset_type),
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216>>
      }
    end

    test "new/1", %{alpha_num4: alpha_num4, asset_type: asset_type} do
      %TrustLineAsset{asset: ^alpha_num4, type: ^asset_type} =
        TrustLineAsset.new(alpha_num4, asset_type)
    end

    test "encode_xdr/1", %{asset: asset, binary: binary} do
      {:ok, ^binary} = TrustLineAsset.encode_xdr(asset)
    end

    test "encode_xdr/1 with an invalid type", %{asset: asset} do
      asset_type = AssetType.new(:NEW_BITCOIN)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     asset
                     |> TrustLineAsset.new(asset_type)
                     |> TrustLineAsset.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{asset: asset, binary: binary} do
      ^binary = TrustLineAsset.encode_xdr!(asset)
    end

    test "decode_xdr/2", %{asset: asset, binary: binary} do
      {:ok, {^asset, ""}} = TrustLineAsset.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TrustLineAsset.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset: asset, binary: binary} do
      {^asset, ^binary} = TrustLineAsset.decode_xdr!(binary <> binary)
    end
  end

  describe "AlphaNum12 Asset" do
    setup %{issuer: issuer} do
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12)

      alpha_num12 =
        "BTCN2021"
        |> AssetCode12.new()
        |> AlphaNum12.new(issuer)

      %{
        alpha_num12: alpha_num12,
        asset_type: asset_type,
        asset: TrustLineAsset.new(alpha_num12, asset_type),
        binary:
          <<0, 0, 0, 2, 66, 84, 67, 78, 50, 48, 50, 49, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56,
            85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{alpha_num12: alpha_num12, asset_type: asset_type} do
      %TrustLineAsset{asset: ^alpha_num12, type: ^asset_type} =
        TrustLineAsset.new(alpha_num12, asset_type)
    end

    test "encode_xdr/1", %{asset: asset, binary: binary} do
      {:ok, ^binary} = TrustLineAsset.encode_xdr(asset)
    end

    test "encode_xdr/1 with an invalid type", %{asset: asset} do
      asset_type = AssetType.new(:NEW_BITCOIN)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     asset
                     |> TrustLineAsset.new(asset_type)
                     |> TrustLineAsset.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{asset: asset, binary: binary} do
      ^binary = TrustLineAsset.encode_xdr!(asset)
    end

    test "decode_xdr/2", %{asset: asset, binary: binary} do
      {:ok, {^asset, ""}} = TrustLineAsset.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TrustLineAsset.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset: asset, binary: binary} do
      {^asset, ^binary} = TrustLineAsset.decode_xdr!(binary <> binary)
    end
  end

  describe "PoolID Asset" do
    setup do
      asset_type = AssetType.new(:ASSET_TYPE_POOL_SHARE)

      pool_id = PoolID.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        pool_id: pool_id,
        asset_type: asset_type,
        asset: TrustLineAsset.new(pool_id, asset_type),
        binary:
          <<0, 0, 0, 3, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{pool_id: pool_id, asset_type: asset_type} do
      %TrustLineAsset{asset: ^pool_id, type: ^asset_type} =
        TrustLineAsset.new(pool_id, asset_type)
    end

    test "encode_xdr/1", %{asset: asset, binary: binary} do
      {:ok, ^binary} = TrustLineAsset.encode_xdr(asset)
    end

    test "encode_xdr/1 with an invalid type", %{asset: asset} do
      asset_type = AssetType.new(:NEW_BITCOIN)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     asset
                     |> TrustLineAsset.new(asset_type)
                     |> TrustLineAsset.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{asset: asset, binary: binary} do
      ^binary = TrustLineAsset.encode_xdr!(asset)
    end

    test "decode_xdr/2", %{asset: asset, binary: binary} do
      {:ok, {^asset, ""}} = TrustLineAsset.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TrustLineAsset.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset: asset, binary: binary} do
      {^asset, ^binary} = TrustLineAsset.decode_xdr!(binary <> binary)
    end
  end
end
