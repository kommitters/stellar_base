defmodule StellarBase.XDR.ChangeTrustAssetTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    ChangeTrustAsset,
    Int32,
    LiquidityPoolType,
    LiquidityPoolParameters,
    PublicKey,
    PublicKeyType,
    Uint256,
    Void
  }

  alias StellarBase.StrKey

  alias StellarBase.XDR.LiquidityPoolConstantProductParameters, as: LiquidityPoolConstant

  setup_all do
    key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

    issuer =
      "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
      |> StrKey.decode!(:ed25519_public_key)
      |> Uint256.new()
      |> PublicKey.new(key_type)
      |> AccountID.new()

    asset_native = Void.new()

    asset_alphanum4 =
      "BTCN"
      |> AssetCode4.new()
      |> AlphaNum4.new(issuer)

    {:ok, %{issuer: issuer, asset_native: asset_native, asset_alphanum4: asset_alphanum4}}
  end

  describe "ChangeTrustAsset AssetNative" do
    setup %{asset_native: asset_native} do
      asset_type = AssetType.new(:ASSET_TYPE_NATIVE)

      %{
        asset: asset_native,
        asset_type: asset_type,
        change_trust: ChangeTrustAsset.new(asset_native, asset_type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{asset: asset, asset_type: asset_type} do
      %ChangeTrustAsset{value: ^asset, type: ^asset_type} =
        ChangeTrustAsset.new(asset, asset_type)
    end

    test "encode_xdr/1", %{change_trust: change_trust, binary: binary} do
      {:ok, ^binary} = ChangeTrustAsset.encode_xdr(change_trust)
    end

    test "encode_xdr/1 with an invalid type", %{change_trust: change_trust} do
      asset_type = AssetType.new(:NEW_BITCOIN)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     change_trust
                     |> ChangeTrustAsset.new(asset_type)
                     |> ChangeTrustAsset.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{change_trust: change_trust, binary: binary} do
      ^binary = ChangeTrustAsset.encode_xdr!(change_trust)
    end

    test "decode_xdr/2", %{change_trust: change_trust, binary: binary} do
      {:ok, {^change_trust, ""}} = ChangeTrustAsset.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ChangeTrustAsset.decode_xdr(123)
    end

    test "decode_xdr!/2", %{change_trust: change_trust, binary: binary} do
      {^change_trust, ^binary} = ChangeTrustAsset.decode_xdr!(binary <> binary)
    end
  end

  describe "ChangeTrustAsset AlphaNum4" do
    setup %{asset_alphanum4: asset_alphanum4} do
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      %{
        asset: asset_alphanum4,
        asset_type: asset_type,
        change_trust: ChangeTrustAsset.new(asset_alphanum4, asset_type),
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216>>
      }
    end

    test "new/1", %{asset: asset, asset_type: asset_type} do
      %ChangeTrustAsset{value: ^asset, type: ^asset_type} =
        ChangeTrustAsset.new(asset, asset_type)
    end

    test "encode_xdr/1", %{change_trust: change_trust, binary: binary} do
      {:ok, ^binary} = ChangeTrustAsset.encode_xdr(change_trust)
    end

    test "encode_xdr!/1", %{change_trust: change_trust, binary: binary} do
      ^binary = ChangeTrustAsset.encode_xdr!(change_trust)
    end

    test "decode_xdr/2", %{change_trust: change_trust, binary: binary} do
      {:ok, {^change_trust, ""}} = ChangeTrustAsset.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{change_trust: change_trust, binary: binary} do
      {^change_trust, ^binary} = ChangeTrustAsset.decode_xdr!(binary <> binary)
    end
  end

  describe "ChangeTrustAsset LiquidityPoolParameters" do
    setup %{asset_native: asset_native, asset_alphanum4: asset_alphanum4} do
      asset_a = Asset.new(asset_native, AssetType.new(:ASSET_TYPE_NATIVE))
      asset_b = Asset.new(asset_alphanum4, AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      liquidity_type = LiquidityPoolType.new(:LIQUIDITY_POOL_CONSTANT_PRODUCT)
      liquidity_product = LiquidityPoolConstant.new(asset_a, asset_b, Int32.new(100))

      asset_type = AssetType.new(:ASSET_TYPE_POOL_SHARE)
      asset = LiquidityPoolParameters.new(liquidity_product, liquidity_type)

      %{
        asset: asset,
        asset_type: asset_type,
        change_trust: ChangeTrustAsset.new(asset, asset_type),
        binary:
          <<0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142,
            186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45,
            179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 100>>
      }
    end

    test "new/1", %{asset: asset, asset_type: asset_type} do
      %ChangeTrustAsset{value: ^asset, type: ^asset_type} =
        ChangeTrustAsset.new(asset, asset_type)
    end

    test "encode_xdr/1", %{change_trust: change_trust, binary: binary} do
      {:ok, ^binary} = ChangeTrustAsset.encode_xdr(change_trust)
    end

    test "encode_xdr!/1", %{change_trust: change_trust, binary: binary} do
      ^binary = ChangeTrustAsset.encode_xdr!(change_trust)
    end

    test "decode_xdr/2", %{change_trust: change_trust, binary: binary} do
      {:ok, {^change_trust, ""}} = ChangeTrustAsset.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{change_trust: change_trust, binary: binary} do
      {^change_trust, ^binary} = ChangeTrustAsset.decode_xdr!(binary <> binary)
    end
  end
end
