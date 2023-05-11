defmodule StellarBase.XDR.LiquidityPoolEntryBodyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    ConstantProduct,
    Int32,
    Int64,
    LiquidityPoolConstantProductParameters,
    LiquidityPoolEntryBody,
    LiquidityPoolType,
    PublicKeyType,
    PublicKey,
    Uint256,
    Void
  }

  alias StellarBase.StrKey

  setup do
    key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

    issuer =
      "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      |> StrKey.decode!(:ed25519_public_key)
      |> Uint256.new()
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

    entry =
      ConstantProduct.new(
        params,
        reserve_a,
        reserve_b,
        total_pool_shares,
        pool_shares_trust_line_count
      )

    type = LiquidityPoolType.new(:LIQUIDITY_POOL_CONSTANT_PRODUCT)

    %{
      type: LiquidityPoolType.new(:LIQUIDITY_POOL_CONSTANT_PRODUCT),
      entry: entry,
      xdr: LiquidityPoolEntryBody.new(entry, type),
      binary:
        <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98,
          27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76,
          25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0,
          0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100>>
    }
  end

  test "new/1", %{type: type, entry: entry} do
    %LiquidityPoolEntryBody{value: ^entry, type: ^type} = LiquidityPoolEntryBody.new(entry, type)
  end

  test "encode_xdr/1", %{xdr: xdr, binary: binary} do
    {:ok, ^binary} = LiquidityPoolEntryBody.encode_xdr(xdr)
  end

  test "encode_xdr!/1", %{xdr: xdr, binary: binary} do
    ^binary = LiquidityPoolEntryBody.encode_xdr!(xdr)
  end

  test "encode_xdr/1 with an invalid type", %{entry: entry} do
    type = LiquidityPoolType.new(:TEST)

    assert_raise XDR.EnumError,
                 "The key which you try to encode doesn't belong to the current declarations",
                 fn ->
                   entry
                   |> LiquidityPoolEntryBody.new(type)
                   |> LiquidityPoolEntryBody.encode_xdr()
                 end
  end

  test "decode_xdr/2", %{xdr: xdr, binary: binary} do
    {:ok, {^xdr, ""}} = LiquidityPoolEntryBody.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = LiquidityPoolEntryBody.decode_xdr(123)
  end

  test "decode_xdr!/2", %{xdr: xdr, binary: binary} do
    {^xdr, ""} = LiquidityPoolEntryBody.decode_xdr!(binary)
  end
end
