defmodule StellarBase.XDR.AlphaNum4Test do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, AlphaNum4, AssetCode4, PublicKey, PublicKeyType, Uint256}

  alias StellarBase.StrKey

  describe "AlphaNum4" do
    setup do
      pk_key =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()

      issuer =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_key, &1)).()
        |> AccountID.new()

      asset_code = AssetCode4.new("BTCN")

      %{
        asset_code: asset_code,
        issuer: issuer,
        alpha_num4: AlphaNum4.new(asset_code, issuer),
        binary:
          <<66, 84, 67, 78, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247,
            67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216>>
      }
    end

    test "new/1", %{asset_code: asset_code, issuer: issuer} do
      %AlphaNum4{asset_code: ^asset_code, issuer: ^issuer} = AlphaNum4.new(asset_code, issuer)
    end

    test "encode_xdr/1", %{alpha_num4: alpha_num4, binary: binary} do
      {:ok, ^binary} = AlphaNum4.encode_xdr(alpha_num4)
    end

    test "encode_xdr!/1", %{alpha_num4: alpha_num4, binary: binary} do
      ^binary = AlphaNum4.encode_xdr!(alpha_num4)
    end

    test "decode_xdr/2", %{alpha_num4: alpha_num4, binary: binary} do
      {:ok, {^alpha_num4, ""}} = AlphaNum4.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AlphaNum4.decode_xdr(123)
    end

    test "decode_xdr!/2", %{alpha_num4: alpha_num4, binary: binary} do
      {^alpha_num4, ^binary} = AlphaNum4.decode_xdr!(binary <> binary)
    end
  end
end
