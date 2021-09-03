defmodule Stellar.XDR.AssetsTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    AccountID,
    AlphaNum4,
    AlphaNum12,
    Asset,
    AssetCode4,
    AssetCode12,
    Assets,
    AssetType,
    AccountID,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  describe "Assets" do
    setup do
      issuer = create_issuer("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
      asset1 = create_asset(:alpha_num4, code: "BTCN", issuer: issuer)
      asset2 = create_asset(:alpha_num12, code: "BTCN2021", issuer: issuer)
      assets_list = [asset1, asset2]

      %{
        issuer: issuer,
        assets_list: assets_list,
        assets: Assets.new(assets_list),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 4, 66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248,
            150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214,
            155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 2, 0, 0, 0, 8, 66, 84, 67, 78, 50,
            48, 50, 49, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216>>
      }
    end

    test "new/1", %{assets_list: assets} do
      %Assets{assets: ^assets} = Assets.new(assets)
    end

    test "encode_xdr/1", %{assets: assets, binary: binary} do
      {:ok, ^binary} = Assets.encode_xdr(assets)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> Assets.new()
        |> Assets.encode_xdr()
    end

    test "encode_xdr/1 with more than 5 elements", %{issuer: issuer} do
      assets = Enum.map(1..6, &create_asset(:alpha_num4, code: "BTC#{&1}", issuer: issuer))

      {:error, :length_over_max} =
        assets
        |> Assets.new()
        |> Assets.encode_xdr()
    end

    test "encode_xdr!/1", %{assets: assets, binary: binary} do
      ^binary = Assets.encode_xdr!(assets)
    end

    test "decode_xdr/2", %{assets: assets, binary: binary} do
      {:ok, {^assets, ""}} = Assets.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Assets.decode_xdr(123)
    end

    test "decode_xdr!/2", %{assets: assets, binary: binary} do
      {^assets, ^binary} = Assets.decode_xdr!(binary <> binary)
    end
  end

  @spec create_asset(type :: atom(), attributes :: Keyword.t()) :: Asset.t()
  defp create_asset(:alpha_num4, code: code, issuer: issuer) do
    asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

    code
    |> AssetCode4.new()
    |> AlphaNum4.new(issuer)
    |> Asset.new(asset_type)
  end

  defp create_asset(:alpha_num12, code: code, issuer: issuer) do
    asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12)

    code
    |> AssetCode12.new()
    |> AlphaNum12.new(issuer)
    |> Asset.new(asset_type)
  end

  @spec create_issuer(public_key :: String.t()) :: AccountID.t()
  defp create_issuer(public_key) do
    pk_key =
      public_key
      |> Stellar.Ed25519.PublicKey.decode!()
      |> UInt256.new()

    PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
    |> (&PublicKey.new(pk_key, &1)).()
    |> AccountID.new()
  end
end
