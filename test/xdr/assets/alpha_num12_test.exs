defmodule Stellar.XDR.AlphaNum12Test do
  use ExUnit.Case

  alias Stellar.XDR.{AccountID, AlphaNum12, AssetCode12, PublicKey, PublicKeyType, UInt256}

  describe "AlphaNum12" do
    setup do
      pk_key =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> Stellar.Ed25519.PublicKey.decode!()
        |> UInt256.new()

      issuer =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_key, &1)).()
        |> AccountID.new()

      asset_code = AssetCode12.new("BTCN2021")

      %{
        asset_code: asset_code,
        issuer: issuer,
        alpha_num12: AlphaNum12.new(asset_code, issuer),
        binary:
          <<0, 0, 0, 8, 66, 84, 67, 78, 50, 48, 50, 49, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56,
            85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{asset_code: asset_code, issuer: issuer} do
      %AlphaNum12{asset_code: ^asset_code, issuer: ^issuer} = AlphaNum12.new(asset_code, issuer)
    end

    test "encode_xdr/1", %{alpha_num12: alpha_num12, binary: binary} do
      {:ok, ^binary} = AlphaNum12.encode_xdr(alpha_num12)
    end

    test "encode_xdr!/1", %{alpha_num12: alpha_num12, binary: binary} do
      ^binary = AlphaNum12.encode_xdr!(alpha_num12)
    end

    test "decode_xdr/2", %{alpha_num12: alpha_num12, binary: binary} do
      {:ok, {^alpha_num12, ""}} = AlphaNum12.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AlphaNum12.decode_xdr(123)
    end

    test "decode_xdr!/2", %{alpha_num12: alpha_num12, binary: binary} do
      {^alpha_num12, ^binary} = AlphaNum12.decode_xdr!(binary <> binary)
    end
  end
end
