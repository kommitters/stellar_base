defmodule StellarBase.XDR.AllowTrustOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    PublicKey,
    PublicKeyType,
    Uint32,
    Uint256
  }

  alias StellarBase.XDR.AllowTrustOp

  alias StellarBase.StrKey

  describe "AllowTrustOp Operation" do
    setup do
      key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(key_type)
        |> AccountID.new()

      account_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(key_type)
        |> AccountID.new()

      asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      authorize = Uint32.new(1)

      allow_trust = AllowTrustOp.new(account_id, asset, authorize)

      %{
        trustor: account_id,
        asset: asset,
        authorize: authorize,
        allow_trust: allow_trust,
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{trustor: trustor, asset: asset, authorize: authorize} do
      %AllowTrustOp{trustor: ^trustor, asset: ^asset, authorize: ^authorize} =
        AllowTrustOp.new(trustor, asset, authorize)
    end

    test "encode_xdr/1", %{allow_trust: allow_trust, binary: binary} do
      {:ok, ^binary} = AllowTrustOp.encode_xdr(allow_trust)
    end

    test "encode_xdr!/1", %{allow_trust: allow_trust, binary: binary} do
      ^binary = AllowTrustOp.encode_xdr!(allow_trust)
    end

    test "decode_xdr/2", %{allow_trust: allow_trust, binary: binary} do
      {:ok, {^allow_trust, ""}} = AllowTrustOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AllowTrustOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{allow_trust: allow_trust, binary: binary} do
      {^allow_trust, ^binary} = AllowTrustOp.decode_xdr!(binary <> binary)
    end
  end
end
