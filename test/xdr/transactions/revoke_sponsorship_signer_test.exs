defmodule StellarBase.XDR.RevokeSponsorshipSignerTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, PublicKey, PublicKeyType, SignerKey, SignerKeyType, UInt256}
  alias StellarBase.XDR.RevokeSponsorshipSigner
  alias StellarBase.StrKey

  describe "RevokeSponsorshipSigner" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
      signer_key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      signer_key =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> SignerKey.new(signer_key_type)

      %{
        account_id: account_id,
        signer_key: signer_key,
        signer: RevokeSponsorshipSigner.new(account_id, signer_key),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0,
            1, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135,
            171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{account_id: account_id, signer_key: signer_key} do
      %RevokeSponsorshipSigner{account_id: ^account_id, signer_key: ^signer_key} =
        RevokeSponsorshipSigner.new(account_id, signer_key)
    end

    test "encode_xdr/1", %{signer: signer, binary: binary} do
      {:ok, ^binary} = RevokeSponsorshipSigner.encode_xdr(signer)
    end

    test "encode_xdr!/1", %{signer: signer, binary: binary} do
      ^binary = RevokeSponsorshipSigner.encode_xdr!(signer)
    end

    test "decode_xdr/2", %{signer: signer, binary: binary} do
      {:ok, {^signer, ""}} = RevokeSponsorshipSigner.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RevokeSponsorshipSigner.decode_xdr(123)
    end

    test "decode_xdr!/2", %{signer: signer, binary: binary} do
      {^signer, ^binary} = RevokeSponsorshipSigner.decode_xdr!(binary <> binary)
    end
  end
end
