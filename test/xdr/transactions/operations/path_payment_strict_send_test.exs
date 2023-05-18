defmodule StellarBase.XDR.PathPaymentStrictSendOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    AlphaNum12,
    Asset,
    AssetList5,
    AssetCode4,
    AssetCode12,
    AssetType,
    CryptoKeyType,
    Int64,
    MuxedAccount,
    PublicKey,
    PublicKeyType,
    Uint256,
    Void
  }

  alias StellarBase.StrKey

  alias StellarBase.XDR.PathPaymentStrictSendOp

  describe "PathPaymentStrictSendOp Operation" do
    setup do
      pk_issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()

      issuer =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_issuer, &1)).()
        |> AccountID.new()

      pk_key =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()

      destination = MuxedAccount.new(pk_key, CryptoKeyType.new(:KEY_TYPE_ED25519))

      send_asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      send_amount = Int64.new(10_000_000)

      dest_asset =
        "BTCNEW2000"
        |> AssetCode12.new()
        |> AlphaNum12.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12))

      dest_min = Int64.new(9_000_000)

      path =
        Void.new()
        |> Asset.new(AssetType.new(:ASSET_TYPE_NATIVE))
        |> (&AssetList5.new([&1])).()

      payment_strict =
        PathPaymentStrictSendOp.new(
          send_asset,
          send_amount,
          destination,
          dest_asset,
          dest_min,
          path
        )

      %{
        send_asset: send_asset,
        send_amount: send_amount,
        destination: destination,
        dest_asset: dest_asset,
        dest_min: dest_min,
        path: path,
        payment_strict: payment_strict,
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 0, 0, 152, 150, 128, 0, 0, 0, 0, 155, 142, 186, 248, 150,
            56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 48,
            48, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 0, 137, 84, 64, 0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      send_asset: send_asset,
      send_amount: send_amount,
      destination: destination,
      dest_asset: dest_asset,
      dest_min: dest_min,
      path: path
    } do
      %PathPaymentStrictSendOp{send_asset: ^send_asset, destination: ^destination, path: ^path} =
        PathPaymentStrictSendOp.new(
          send_asset,
          send_amount,
          destination,
          dest_asset,
          dest_min,
          path
        )
    end

    test "encode_xdr/1", %{payment_strict: payment_strict, binary: binary} do
      {:ok, ^binary} = PathPaymentStrictSendOp.encode_xdr(payment_strict)
    end

    test "encode_xdr!/1", %{payment_strict: payment_strict, binary: binary} do
      ^binary = PathPaymentStrictSendOp.encode_xdr!(payment_strict)
    end

    test "decode_xdr/2", %{payment_strict: payment_strict, binary: binary} do
      {:ok, {^payment_strict, ""}} = PathPaymentStrictSendOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PathPaymentStrictSendOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{payment_strict: payment_strict, binary: binary} do
      {^payment_strict, ^binary} = PathPaymentStrictSendOp.decode_xdr!(binary <> binary)
    end
  end
end
