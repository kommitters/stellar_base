defmodule StellarBase.XDR.Operations.ConstantProductTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ConstantProduct,
    LiquidityPoolConstantProductParameters,
    Int64,
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

  describe "ConstantProduct" do
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
      reserve_a = Int64.new(100)
      reserve_b = Int64.new(100)
      total_pool_shares = Int64.new(100)
      pool_shares_trust_line_count = Int64.new(100)

      params = LiquidityPoolConstantProductParameters.new(asset_a, asset_b, fee)

      %{
        params: params,
        reserve_a: reserve_a,
        reserve_b: reserve_b,
        total_pool_shares: total_pool_shares,
        pool_shares_trust_line_count: pool_shares_trust_line_count,
        constant_product:
          ConstantProduct.new(
            params,
            reserve_a,
            reserve_b,
            total_pool_shares,
            pool_shares_trust_line_count
          ),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186,
            154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25,
            212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0,
            0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100>>
      }
    end

    test "new/1", %{
      params: params,
      reserve_a: reserve_a,
      reserve_b: reserve_b,
      total_pool_shares: total_pool_shares,
      pool_shares_trust_line_count: pool_shares_trust_line_count
    } do
      %ConstantProduct{
        params: ^params,
        reserve_a: ^reserve_a,
        reserve_b: ^reserve_b,
        total_pool_shares: ^total_pool_shares,
        pool_shares_trust_line_count: ^pool_shares_trust_line_count
      } =
        ConstantProduct.new(
          params,
          reserve_a,
          reserve_b,
          total_pool_shares,
          pool_shares_trust_line_count
        )
    end

    test "encode_xdr/1", %{constant_product: constant_product, binary: binary} do
      {:ok, ^binary} = ConstantProduct.encode_xdr(constant_product)
    end

    test "encode_xdr!/1", %{constant_product: constant_product, binary: binary} do
      ^binary = ConstantProduct.encode_xdr!(constant_product)
    end

    test "decode_xdr/2", %{constant_product: constant_product, binary: binary} do
      {:ok, {^constant_product, ""}} = ConstantProduct.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ConstantProduct.decode_xdr(123)
    end

    test "decode_xdr!/2", %{constant_product: constant_product, binary: binary} do
      {^constant_product, ^binary} = ConstantProduct.decode_xdr!(binary <> binary)
    end
  end
end
