defmodule Stellar.XDR.AssetTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  describe "Asset" do
    setup do
      pk_key =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> Stellar.Ed25519.PublicKey.decode!()
        |> UInt256.new()

      issuer =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_key, &1)).()
        |> AccountID.new()

      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      alpha_num4 =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)

      %{
        alpha_num4: alpha_num4,
        asset_type: asset_type,
        asset: Asset.new(alpha_num4, asset_type),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 4, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85,
            29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117,
            165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{alpha_num4: alpha_num4, asset_type: asset_type} do
      %Asset{asset: ^alpha_num4, type: ^asset_type} = Asset.new(alpha_num4, asset_type)
    end

    test "encode_xdr/1", %{asset: asset, binary: binary} do
      {:ok, ^binary} = Asset.encode_xdr(asset)
    end

    test "encode_xdr/1 with an invalid type", %{asset: asset} do
      asset_type = AssetType.new(:NEW_BITCOIN)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     asset
                     |> Asset.new(asset_type)
                     |> Asset.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{asset: asset, binary: binary} do
      ^binary = Asset.encode_xdr!(asset)
    end

    test "decode_xdr/2", %{asset: asset, binary: binary} do
      {:ok, {^asset, ""}} = Asset.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Asset.decode_xdr(123)
    end

    test "decode_xdr!/2", %{asset: asset, binary: binary} do
      {^asset, ^binary} = Asset.decode_xdr!(binary <> binary)
    end
  end
end