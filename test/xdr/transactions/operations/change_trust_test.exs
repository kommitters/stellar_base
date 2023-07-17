defmodule StellarBase.XDR.ChangeTrustTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    AssetCode4,
    AlphaNum12,
    AssetCode12,
    AssetType,
    ChangeTrust,
    ChangeTrustAsset,
    Int64,
    PublicKey,
    PublicKeyType,
    UInt256,
    Void
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

    asset_native = Void.new()

    asset_alphanum4 =
      "BTCN"
      |> AssetCode4.new()
      |> AlphaNum4.new(issuer)

    asset_alphanum12 =
      "BTCNEW2000"
      |> AssetCode12.new()
      |> AlphaNum12.new(issuer)

    {:ok,
     %{
       asset_native: asset_native,
       asset_alphanum4: asset_alphanum4,
       asset_alphanum12: asset_alphanum12
     }}
  end

  describe "ChangeTrust Operation Native Asset" do
    setup %{asset_native: asset_native} do
      asset_type = AssetType.new(:ASSET_TYPE_NATIVE)
      asset = ChangeTrustAsset.new(asset_native, asset_type)
      limit = Int64.new(100_000_000_000)

      %{
        asset: asset,
        limit: limit,
        change_trust: ChangeTrust.new(asset, limit),
        binary: <<0, 0, 0, 0, 0, 0, 0, 23, 72, 118, 232, 0>>
      }
    end

    test "new/1", %{asset: asset, limit: limit} do
      %ChangeTrust{asset: ^asset, limit: ^limit} = ChangeTrust.new(asset, limit)
    end

    test "encode_xdr/1", %{change_trust: change_trust, binary: binary} do
      {:ok, ^binary} = ChangeTrust.encode_xdr(change_trust)
    end

    test "encode_xdr!/1", %{change_trust: change_trust, binary: binary} do
      ^binary = ChangeTrust.encode_xdr!(change_trust)
    end

    test "decode_xdr/2", %{change_trust: change_trust, binary: binary} do
      {:ok, {^change_trust, ""}} = ChangeTrust.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ChangeTrust.decode_xdr(123)
    end

    test "decode_xdr!/2", %{change_trust: change_trust, binary: binary} do
      {^change_trust, ^binary} = ChangeTrust.decode_xdr!(binary <> binary)
    end
  end

  describe "ChangeTrust Operation AlphaNum4 Asset" do
    setup %{asset_alphanum4: asset_alphanum4} do
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)
      asset = ChangeTrustAsset.new(asset_alphanum4, asset_type)
      limit = Int64.new(100_000_000_000)

      %{
        asset: asset,
        limit: limit,
        change_trust: ChangeTrust.new(asset, limit),
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158,
            164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34,
            114, 247, 89, 216, 0, 0, 0, 23, 72, 118, 232, 0>>
      }
    end

    test "new/1", %{asset: asset, limit: limit} do
      %ChangeTrust{asset: ^asset, limit: ^limit} = ChangeTrust.new(asset, limit)
    end

    test "encode_xdr/1", %{change_trust: change_trust, binary: binary} do
      {:ok, ^binary} = ChangeTrust.encode_xdr(change_trust)
    end

    test "encode_xdr!/1", %{change_trust: change_trust, binary: binary} do
      ^binary = ChangeTrust.encode_xdr!(change_trust)
    end

    test "decode_xdr/2", %{change_trust: change_trust, binary: binary} do
      {:ok, {^change_trust, ""}} = ChangeTrust.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ChangeTrust.decode_xdr(123)
    end

    test "decode_xdr!/2", %{change_trust: change_trust, binary: binary} do
      {^change_trust, ^binary} = ChangeTrust.decode_xdr!(binary <> binary)
    end
  end

  describe "ChangeTrust Operation AlphaNum12 Asset" do
    setup %{asset_alphanum12: asset_alphanum12} do
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12)
      asset = ChangeTrustAsset.new(asset_alphanum12, asset_type)
      limit = Int64.new(100_000_000_000)

      %{
        asset: asset,
        limit: limit,
        change_trust: ChangeTrust.new(asset, limit),
        binary:
          <<0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 48, 48, 0, 0, 0, 0, 0, 0, 155, 142, 186,
            248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179,
            214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 23, 72, 118, 232, 0>>
      }
    end

    test "new/1", %{asset: asset, limit: limit} do
      %ChangeTrust{asset: ^asset, limit: ^limit} = ChangeTrust.new(asset, limit)
    end

    test "encode_xdr/1", %{change_trust: change_trust, binary: binary} do
      {:ok, ^binary} = ChangeTrust.encode_xdr(change_trust)
    end

    test "encode_xdr!/1", %{change_trust: change_trust, binary: binary} do
      ^binary = ChangeTrust.encode_xdr!(change_trust)
    end

    test "decode_xdr/2", %{change_trust: change_trust, binary: binary} do
      {:ok, {^change_trust, ""}} = ChangeTrust.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ChangeTrust.decode_xdr(123)
    end

    test "decode_xdr!/2", %{change_trust: change_trust, binary: binary} do
      {^change_trust, ^binary} = ChangeTrust.decode_xdr!(binary <> binary)
    end
  end
end
