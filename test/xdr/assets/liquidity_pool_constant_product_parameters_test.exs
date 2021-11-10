defmodule StellarBase.XDR.Operations.LiquidityPoolConstantProductParametersTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    Int32,
    PublicKey,
    PublicKeyType,
    UInt256,
    Void
  }

  alias StellarBase.StrKey

  alias StellarBase.XDR.LiquidityPoolConstantProductParameters, as: LiquidityPoolConstant

  describe "LiquidityPoolConstantProductParameters" do
    setup do
      key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(key_type)
        |> AccountID.new()

      asset_a = Asset.new(Void.new(), AssetType.new(:ASSET_TYPE_NATIVE))

      asset_b =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      fee = Int32.new(100)

      %{
        asset_a: asset_a,
        asset_b: asset_b,
        fee: fee,
        liquidity_pool: LiquidityPoolConstant.new(asset_a, asset_b, fee),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186,
            154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25,
            212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 100>>
      }
    end

    test "new/1", %{asset_a: asset_a, asset_b: asset_b, fee: fee} do
      %LiquidityPoolConstant{asset_a: ^asset_a, asset_b: ^asset_b, fee: ^fee} =
        LiquidityPoolConstant.new(asset_a, asset_b, fee)
    end

    test "encode_xdr/1", %{liquidity_pool: liquidity_pool, binary: binary} do
      {:ok, ^binary} = LiquidityPoolConstant.encode_xdr(liquidity_pool)
    end

    test "encode_xdr!/1", %{liquidity_pool: liquidity_pool, binary: binary} do
      ^binary = LiquidityPoolConstant.encode_xdr!(liquidity_pool)
    end

    test "decode_xdr/2", %{liquidity_pool: liquidity_pool, binary: binary} do
      {:ok, {^liquidity_pool, ""}} = LiquidityPoolConstant.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LiquidityPoolConstant.decode_xdr(123)
    end

    test "decode_xdr!/2", %{liquidity_pool: liquidity_pool, binary: binary} do
      {^liquidity_pool, ^binary} = LiquidityPoolConstant.decode_xdr!(binary <> binary)
    end
  end
end
