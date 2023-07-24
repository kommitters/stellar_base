defmodule StellarBase.XDR.RevokeSponsorshipOpSignerTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    RevokeSponsorshipOpSigner,
    PublicKey,
    PublicKeyType,
    SignerKey,
    SignerKeyType,
    UInt256
  }

  describe "RevokeSponsorshipOpSigner" do
    setup do
      signer_key = %UInt256{
        datum:
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
      }

      public_key = %PublicKey{
        public_key: signer_key,
        type: %PublicKeyType{
          identifier: :PUBLIC_KEY_TYPE_ED25519
        }
      }

      key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_PRE_AUTH_TX)
      account_id = AccountID.new(public_key)
      signer_key = SignerKey.new(signer_key, key_type)

      %{
        account_id: account_id,
        signer_key: signer_key,
        revoke_sponsorship_op_signer: RevokeSponsorshipOpSigner.new(account_id, signer_key),
        binary:
          <<0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243,
            51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35, 0, 0, 0, 1,
            18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
      }
    end

    test "new/1", %{account_id: account_id, signer_key: signer_key} do
      %RevokeSponsorshipOpSigner{
        account_id: ^account_id,
        signer_key: ^signer_key
      } =
        RevokeSponsorshipOpSigner.new(
          account_id,
          signer_key
        )
    end

    test "encode_xdr/1", %{
      revoke_sponsorship_op_signer: revoke_sponsorship_op_signer,
      binary: binary
    } do
      {:ok, ^binary} = RevokeSponsorshipOpSigner.encode_xdr(revoke_sponsorship_op_signer)
    end

    test "encode_xdr!/1", %{
      revoke_sponsorship_op_signer: revoke_sponsorship_op_signer,
      binary: binary
    } do
      ^binary = RevokeSponsorshipOpSigner.encode_xdr!(revoke_sponsorship_op_signer)
    end

    test "decode_xdr/2", %{
      revoke_sponsorship_op_signer: revoke_sponsorship_op_signer,
      binary: binary
    } do
      {:ok, {^revoke_sponsorship_op_signer, ""}} = RevokeSponsorshipOpSigner.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RevokeSponsorshipOpSigner.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      revoke_sponsorship_op_signer: revoke_sponsorship_op_signer,
      binary: binary
    } do
      {^revoke_sponsorship_op_signer, ^binary} =
        RevokeSponsorshipOpSigner.decode_xdr!(binary <> binary)
    end
  end
end
