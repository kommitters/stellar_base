defmodule StellarBase.XDR.ManageSellOfferTest do
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
    ManageSellOffer,
    Price,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "ManageSellOffer Operation" do
    setup do
      pk_issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()

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
      offer_id = Int64.new(0)

      manage_sell_offer = ManageSellOffer.new(asset1, asset2, amount, price, offer_id)

      %{
        selling: asset1,
        buying: asset2,
        amount: amount,
        price: price,
        offer_id: offer_id,
        manage_sell_offer: manage_sell_offer,
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 48, 48, 0, 0, 0, 0, 0,
            0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187,
            173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 152,
            150, 128, 0, 0, 0, 1, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      selling: selling,
      buying: buying,
      amount: amount,
      price: price,
      offer_id: offer_id
    } do
      %ManageSellOffer{selling: ^selling, buying: ^buying, amount: ^amount} =
        ManageSellOffer.new(selling, buying, amount, price, offer_id)
    end

    test "encode_xdr/1", %{manage_sell_offer: manage_sell_offer, binary: binary} do
      {:ok, ^binary} = ManageSellOffer.encode_xdr(manage_sell_offer)
    end

    test "encode_xdr!/1", %{manage_sell_offer: manage_sell_offer, binary: binary} do
      ^binary = ManageSellOffer.encode_xdr!(manage_sell_offer)
    end

    test "decode_xdr/2", %{manage_sell_offer: manage_sell_offer, binary: binary} do
      {:ok, {^manage_sell_offer, ""}} = ManageSellOffer.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ManageSellOffer.decode_xdr(123)
    end

    test "decode_xdr!/2", %{manage_sell_offer: manage_sell_offer, binary: binary} do
      {^manage_sell_offer, ^binary} = ManageSellOffer.decode_xdr!(binary <> binary)
    end
  end
end
