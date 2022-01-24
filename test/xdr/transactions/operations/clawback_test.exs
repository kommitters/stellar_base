defmodule StellarBase.XDR.Operations.ClawbackTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    CryptoKeyType,
    Int64,
    MuxedAccount,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  alias StellarBase.XDR.Operations.Clawback

  alias StellarBase.StrKey

  describe "Clawback Operation" do
    setup do
      pk_issuer_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
      account_key_type = CryptoKeyType.new(:KEY_TYPE_ED25519)

      issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_issuer_type)
        |> AccountID.new()

      asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      from =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> MuxedAccount.new(account_key_type)

      amount = Int64.new(10_000_000)

      %{
        asset: asset,
        from: from,
        amount: amount,
        clawback: Clawback.new(asset, from, amount),
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247,
            67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0, 0, 152, 150, 128>>
      }
    end

    test "new/1", %{asset: asset, from: from, amount: amount} do
      %Clawback{asset: ^asset, from: ^from, amount: ^amount} = Clawback.new(asset, from, amount)
    end

    test "encode_xdr/1", %{clawback: clawback, binary: binary} do
      {:ok, ^binary} = Clawback.encode_xdr(clawback)
    end

    test "encode_xdr!/1", %{clawback: clawback, binary: binary} do
      ^binary = Clawback.encode_xdr!(clawback)
    end

    test "decode_xdr/2", %{clawback: clawback, binary: binary} do
      {:ok, {^clawback, ""}} = Clawback.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Clawback.decode_xdr(123)
    end

    test "decode_xdr!/2", %{clawback: clawback, binary: binary} do
      {^clawback, ^binary} = Clawback.decode_xdr!(binary <> binary)
    end
  end
end
