defmodule Stellar.XDR.Operations.PathPaymentStrictReceiveTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    AccountID,
    AlphaNum4,
    AlphaNum12,
    Asset,
    Assets,
    AssetCode4,
    AssetCode12,
    AssetType,
    CryptoKeyType,
    Int64,
    MuxedAccount,
    PublicKey,
    PublicKeyType,
    UInt256,
    Void
  }

  alias Stellar.XDR.Operations.PathPaymentStrictReceive

  describe "PathPaymentStrictReceive Operation" do
    setup do
      pk_issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> Stellar.Ed25519.PublicKey.decode!()
        |> UInt256.new()

      issuer =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_issuer, &1)).()
        |> AccountID.new()

      pk_key =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> Stellar.Ed25519.PublicKey.decode!()
        |> UInt256.new()

      destination = CryptoKeyType.new(:KEY_TYPE_ED25519) |> MuxedAccount.new(pk_key)

      send_asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      send_max = Int64.new(10_000_000)

      dest_asset =
        "BTCNEW2000"
        |> AssetCode12.new()
        |> AlphaNum12.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12))

      dest_amount = Int64.new(9_000_000)

      path =
        Void.new()
        |> Asset.new(AssetType.new(:ASSET_TYPE_NATIVE))
        |> (&Assets.new([&1])).()

      payment_strict =
        PathPaymentStrictReceive.new(
          send_asset,
          send_max,
          destination,
          dest_asset,
          dest_amount,
          path
        )

      %{
        send_asset: send_asset,
        send_max: send_max,
        destination: destination,
        dest_asset: dest_asset,
        dest_amount: dest_amount,
        path: path,
        payment_strict: payment_strict,
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 0, 0, 152, 150, 128, 0, 0, 0, 2, 66, 84, 67, 78, 69, 87, 50, 48, 48, 48,
            0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205,
            198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0,
            0, 0, 0, 0, 137, 84, 64, 0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      send_asset: send_asset,
      send_max: send_max,
      destination: destination,
      dest_asset: dest_asset,
      dest_amount: dest_amount,
      path: path
    } do
      %PathPaymentStrictReceive{send_asset: ^send_asset, destination: ^destination, path: ^path} =
        PathPaymentStrictReceive.new(
          destination,
          send_asset,
          send_max,
          dest_asset,
          dest_amount,
          path
        )
    end

    test "encode_xdr/1", %{payment_strict: payment_strict, binary: binary} do
      {:ok, ^binary} = PathPaymentStrictReceive.encode_xdr(payment_strict)
    end

    test "encode_xdr!/1", %{payment_strict: payment_strict, binary: binary} do
      ^binary = PathPaymentStrictReceive.encode_xdr!(payment_strict)
    end

    test "decode_xdr/2", %{payment_strict: payment_strict, binary: binary} do
      {:ok, {^payment_strict, ""}} = PathPaymentStrictReceive.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PathPaymentStrictReceive.decode_xdr(123)
    end

    test "decode_xdr!/2", %{payment_strict: payment_strict, binary: binary} do
      {^payment_strict, ^binary} = PathPaymentStrictReceive.decode_xdr!(binary <> binary)
    end
  end
end
