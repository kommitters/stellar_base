defmodule StellarBase.XDR.LedgerKeyTrustLineTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    AssetCode4,
    AssetType,
    LedgerKeyTrustLine,
    PublicKey,
    PublicKeyType,
    TrustLineAsset,
    Uint256
  }

  alias StellarBase.StrKey

  describe "Ledger LedgerKeyTrustLine" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      account_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)

      asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> TrustLineAsset.new(asset_type)

      %{
        account_id: account_id,
        asset: asset,
        account: LedgerKeyTrustLine.new(account_id, asset),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119>>
      }
    end

    test "new/1", %{account_id: account_id, asset: asset} do
      %LedgerKeyTrustLine{account_id: ^account_id, asset: ^asset} =
        LedgerKeyTrustLine.new(account_id, asset)
    end

    test "encode_xdr/1", %{account: account, binary: binary} do
      {:ok, ^binary} = LedgerKeyTrustLine.encode_xdr(account)
    end

    test "encode_xdr!/1", %{account: account, binary: binary} do
      ^binary = LedgerKeyTrustLine.encode_xdr!(account)
    end

    test "decode_xdr/2", %{account: account, binary: binary} do
      {:ok, {^account, ""}} = LedgerKeyTrustLine.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyTrustLine.decode_xdr(123)
    end

    test "decode_xdr!/2", %{account: account, binary: binary} do
      {^account, ^binary} = LedgerKeyTrustLine.decode_xdr!(binary <> binary)
    end
  end
end
