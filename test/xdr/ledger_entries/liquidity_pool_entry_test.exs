defmodule StellarBase.XDR.LiquidityPoolEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    LiquidityPoolEntryConstantProduct,
    LiquidityPoolEntry,
    LiquidityPoolEntryBody,
    LiquidityPoolConstantProductParameters,
    LiquidityPoolType,
    Int64,
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    Int32,
    PoolID,
    PublicKey,
    PublicKeyType,
    Uint256,
    Void
  }

  alias StellarBase.StrKey

  describe "LiquidityPoolEntry" do
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
        LiquidityPoolEntryConstantProduct.new(
          params,
          reserve_a,
          reserve_b,
          total_pool_shares,
          pool_shares_trust_line_count
        )

      type = LiquidityPoolType.new(:LIQUIDITY_POOL_CONSTANT_PRODUCT)
      body = LiquidityPoolEntryBody.new(entry, type)
      liquidity_pool_id = PoolID.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        body: body,
        liquidity_pool_id: liquidity_pool_id,
        liquidity_pool_entry: LiquidityPoolEntry.new(body, liquidity_pool_id),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144,
            98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37,
            10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 0,
            0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 71, 67, 73,
            90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84, 72, 77, 68,
            90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{body: body, liquidity_pool_id: liquidity_pool_id} do
      %LiquidityPoolEntry{body: ^body, liquidity_pool_id: ^liquidity_pool_id} =
        LiquidityPoolEntry.new(body, liquidity_pool_id)
    end

    test "encode_xdr/1", %{liquidity_pool_entry: liquidity_pool_entry, binary: binary} do
      {:ok, ^binary} = LiquidityPoolEntry.encode_xdr(liquidity_pool_entry)
    end

    test "encode_xdr!/1", %{liquidity_pool_entry: liquidity_pool_entry, binary: binary} do
      ^binary = LiquidityPoolEntry.encode_xdr!(liquidity_pool_entry)
    end

    test "decode_xdr/2", %{liquidity_pool_entry: liquidity_pool_entry, binary: binary} do
      {:ok, {^liquidity_pool_entry, ""}} = LiquidityPoolEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LiquidityPoolEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{liquidity_pool_entry: liquidity_pool_entry, binary: binary} do
      {^liquidity_pool_entry, ^binary} = LiquidityPoolEntry.decode_xdr!(binary <> binary)
    end
  end
end
