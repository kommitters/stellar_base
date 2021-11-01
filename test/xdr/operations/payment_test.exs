defmodule Stellar.XDR.Operations.PaymentTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    AccountID,
    AlphaNum4,
    AlphaNum12,
    Asset,
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

  alias Stellar.XDR.Operations.Payment

  setup_all do
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

    account = MuxedAccount.new(pk_key, CryptoKeyType.new(:KEY_TYPE_ED25519))

    {:ok, %{issuer: issuer, account: account}}
  end

  describe "NativeAsset Payment Operation" do
    setup %{account: account} do
      asset_type = AssetType.new(:ASSET_TYPE_NATIVE)
      asset = Asset.new(Void.new(), asset_type)
      amount = Int64.new(1_000_000)
      payment = Payment.new(account, asset, amount)

      %{
        asset: asset,
        amount: amount,
        payment: payment,
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 15, 66, 64>>
      }
    end

    test "new/1", %{account: account, asset: asset, amount: amount} do
      %Payment{destination: ^account, asset: ^asset} = Payment.new(account, asset, amount)
    end

    test "encode_xdr/1", %{payment: payment, binary: binary} do
      {:ok, ^binary} = Payment.encode_xdr(payment)
    end

    test "encode_xdr!/1", %{payment: payment, binary: binary} do
      ^binary = Payment.encode_xdr!(payment)
    end

    test "decode_xdr/2", %{payment: payment, binary: binary} do
      {:ok, {^payment, ""}} = Payment.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Payment.decode_xdr(123)
    end

    test "decode_xdr!/2", %{payment: payment, binary: binary} do
      {^payment, ^binary} = Payment.decode_xdr!(binary <> binary)
    end
  end

  describe "AlphaNum4 Asset Payment Operation" do
    setup %{account: account, issuer: issuer} do
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(asset_type)

      amount = Int64.new(1_000_000)
      payment = Payment.new(account, asset, amount)

      %{
        asset: asset,
        amount: amount,
        payment: payment,
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 0, 0, 15, 66, 64>>
      }
    end

    test "new/1", %{account: account, asset: asset, amount: amount} do
      %Payment{destination: ^account, asset: ^asset} = Payment.new(account, asset, amount)
    end

    test "encode_xdr/1", %{payment: payment, binary: binary} do
      {:ok, ^binary} = Payment.encode_xdr(payment)
    end

    test "encode_xdr!/1", %{payment: payment, binary: binary} do
      ^binary = Payment.encode_xdr!(payment)
    end

    test "decode_xdr/2", %{payment: payment, binary: binary} do
      {:ok, {^payment, ""}} = Payment.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{payment: payment, binary: binary} do
      {^payment, ^binary} = Payment.decode_xdr!(binary <> binary)
    end
  end

  describe "AlphaNum12 Asset Payment Operation" do
    setup %{account: account, issuer: issuer} do
      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12)

      asset =
        "BTCNEW2000"
        |> AssetCode12.new()
        |> AlphaNum12.new(issuer)
        |> Asset.new(asset_type)

      amount = Int64.new(1_000_000)
      payment = Payment.new(account, asset, amount)

      %{
        asset: asset,
        amount: amount,
        payment: payment,
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 2,
            66, 84, 67, 78, 69, 87, 50, 48, 48, 48, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27,
            186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76,
            25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 15, 66, 64>>
      }
    end

    test "new/1", %{account: account, asset: asset, amount: amount} do
      %Payment{destination: ^account, asset: ^asset} = Payment.new(account, asset, amount)
    end

    test "encode_xdr/1", %{payment: payment, binary: binary} do
      {:ok, ^binary} = Payment.encode_xdr(payment)
    end

    test "encode_xdr!/1", %{payment: payment, binary: binary} do
      ^binary = Payment.encode_xdr!(payment)
    end

    test "decode_xdr/2", %{payment: payment, binary: binary} do
      {:ok, {^payment, ""}} = Payment.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{payment: payment, binary: binary} do
      {^payment, ^binary} = Payment.decode_xdr!(binary <> binary)
    end
  end
end
