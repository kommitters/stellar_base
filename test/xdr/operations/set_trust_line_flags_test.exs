defmodule StellarBase.XDR.Operations.SetTrustLineFlagsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
    PublicKey,
    PublicKeyType,
    UInt32,
    UInt256
  }

  alias StellarBase.XDR.Operations.SetTrustLineFlags

  alias StellarBase.StrKey

  describe "SetTrustLineFlags Operation" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      trustor =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      clear_flags = UInt32.new(0)

      set_flags = UInt32.new(2)

      %{
        trustor: trustor,
        asset: asset,
        clear_flags: clear_flags,
        set_flags: set_flags,
        set_trust_line_flags: SetTrustLineFlags.new(trustor, asset, clear_flags, set_flags),
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 1,
            66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154,
            124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119, 0, 0, 0, 0, 0, 0, 0, 2>>
      }
    end

    test "new/1", %{
      trustor: trustor,
      asset: asset,
      clear_flags: clear_flags,
      set_flags: set_flags
    } do
      %SetTrustLineFlags{
        trustor: ^trustor,
        asset: ^asset,
        clear_flags: ^clear_flags,
        set_flags: ^set_flags
      } = SetTrustLineFlags.new(trustor, asset, clear_flags, set_flags)
    end

    test "encode_xdr/1", %{set_trust_line_flags: set_trust_line_flags, binary: binary} do
      {:ok, ^binary} = SetTrustLineFlags.encode_xdr(set_trust_line_flags)
    end

    test "encode_xdr!/1", %{set_trust_line_flags: set_trust_line_flags, binary: binary} do
      ^binary = SetTrustLineFlags.encode_xdr!(set_trust_line_flags)
    end

    test "decode_xdr/2", %{set_trust_line_flags: set_trust_line_flags, binary: binary} do
      {:ok, {^set_trust_line_flags, ""}} = SetTrustLineFlags.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SetTrustLineFlags.decode_xdr(123)
    end

    test "decode_xdr!/2", %{set_trust_line_flags: set_trust_line_flags, binary: binary} do
      {^set_trust_line_flags, ^binary} = SetTrustLineFlags.decode_xdr!(binary <> binary)
    end
  end
end
