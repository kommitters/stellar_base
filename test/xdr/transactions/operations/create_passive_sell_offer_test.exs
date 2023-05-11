defmodule StellarBase.XDR.CreatePassiveSellOfferOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    AlphaNum12,
    Asset,
    AssetCode4,
    AssetCode12,
    AssetType,
    Int32,
    Int64,
    Price,
    PublicKey,
    PublicKeyType,
    Uint256
  }

  alias StellarBase.StrKey

  alias StellarBase.XDR.CreatePassiveSellOfferOp

  describe "CreatePassiveSellOfferOp Operation" do
    setup do
      pk_issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()

      issuer =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_issuer, &1)).()
        |> AccountID.new()

      asset1 =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      asset2 =
        "BTCNEW2000"
        |> AssetCode12.new()
        |> AlphaNum12.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12))

      amount = Int64.new(10_000_000)
      price = Price.new(Int32.new(1), Int32.new(10))

      passive_sell_offer = CreatePassiveSellOfferOp.new(asset1, asset2, amount, price)

      %{
        selling: asset1,
        buying: asset2,
        amount: amount,
        price: price,
        passive_sell_offer: passive_sell_offer,
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 48, 48, 0, 0, 0, 0, 0,
            0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187,
            173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 152,
            150, 128, 0, 0, 0, 1, 0, 0, 0, 10>>
      }
    end

    test "new/1", %{selling: selling, buying: buying, amount: amount, price: price} do
      %CreatePassiveSellOfferOp{selling: ^selling, buying: ^buying, amount: ^amount} =
        CreatePassiveSellOfferOp.new(selling, buying, amount, price)
    end

    test "encode_xdr/1", %{passive_sell_offer: passive_sell_offer, binary: binary} do
      {:ok, ^binary} = CreatePassiveSellOfferOp.encode_xdr(passive_sell_offer)
    end

    test "encode_xdr!/1", %{passive_sell_offer: passive_sell_offer, binary: binary} do
      ^binary = CreatePassiveSellOfferOp.encode_xdr!(passive_sell_offer)
    end

    test "decode_xdr/2", %{passive_sell_offer: passive_sell_offer, binary: binary} do
      {:ok, {^passive_sell_offer, ""}} = CreatePassiveSellOfferOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreatePassiveSellOfferOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{passive_sell_offer: passive_sell_offer, binary: binary} do
      {^passive_sell_offer, ^binary} = CreatePassiveSellOfferOp.decode_xdr!(binary <> binary)
    end
  end
end
