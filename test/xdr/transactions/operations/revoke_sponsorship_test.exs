defmodule StellarBase.XDR.RevokeSponsorshipOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    LedgerEntryType,
    LedgerKey,
    RevokeSponsorshipOpType,
    PublicKey,
    PublicKeyType,
    SignerKey,
    SignerKeyType,
    Uint256
  }

  alias StellarBase.XDR.{Account, RevokeSponsorshipOpSigner}
  alias StellarBase.XDR.RevokeSponsorshipOp
  alias StellarBase.StrKey

  setup do
    pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

    account_id =
      "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      |> StrKey.decode!(:ed25519_public_key)
      |> Uint256.new()
      |> PublicKey.new(pk_type)
      |> AccountID.new()

    {:ok, %{account_id: account_id}}
  end

  describe "LedgerKey RevokeSponsorshipOp" do
    setup %{account_id: account_id} do
      sponsorship_type = RevokeSponsorshipOpType.new(:REVOKE_SPONSORSHIP_LEDGER_ENTRY)

      ledger_key =
        account_id
        |> Account.new()
        |> LedgerKey.new(LedgerEntryType.new(:ACCOUNT))

      %{
        type: sponsorship_type,
        ledger_key: ledger_key,
        revoke_sponsorship: RevokeSponsorshipOp.new(ledger_key, sponsorship_type),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119>>
      }
    end

    test "new/1", %{ledger_key: ledger_key, type: sponsorship_type} do
      %RevokeSponsorshipOp{value: ^ledger_key, type: ^sponsorship_type} =
        RevokeSponsorshipOp.new(ledger_key, sponsorship_type)
    end

    test "encode_xdr/1", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      {:ok, ^binary} = RevokeSponsorshipOp.encode_xdr(revoke_sponsorship)
    end

    test "encode_xdr!/1", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      ^binary = RevokeSponsorshipOp.encode_xdr!(revoke_sponsorship)
    end

    test "decode_xdr/2", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      {:ok, {^revoke_sponsorship, ""}} = RevokeSponsorshipOp.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      {^revoke_sponsorship, ^binary} = RevokeSponsorshipOp.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RevokeSponsorshipOp.decode_xdr(123)
    end

    test "invalid identifier", %{ledger_key: ledger_key} do
      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     ledger_key
                     |> RevokeSponsorshipOp.new(RevokeSponsorshipOpType.new(:TEST))
                     |> RevokeSponsorshipOp.encode_xdr()
                   end
    end
  end

  describe "Signer RevokeSponsorshipOp" do
    setup %{account_id: account_id} do
      sponsorship_type = RevokeSponsorshipOpType.new(:REVOKE_SPONSORSHIP_SIGNER)
      signer_key_type = SignerKeyType.new(:SIGNER_KEY_TYPE_ED25519)

      signer_key =
        "SBZ3IBDFXTY2R47DOFOZLPNABQCABHD2FLZ3P6GM3P3CZEM6CB3ITLBD"
        |> StrKey.decode!(:ed25519_secret_seed)
        |> Uint256.new()
        |> SignerKey.new(signer_key_type)

      signer = RevokeSponsorshipOpSigner.new(account_id, signer_key)

      %{
        type: sponsorship_type,
        signer: signer,
        revoke_sponsorship: RevokeSponsorshipOp.new(signer, sponsorship_type),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 115, 180, 4, 101, 188, 241, 168, 243, 227, 113, 93, 149, 189, 160, 12, 4,
            0, 156, 122, 42, 243, 183, 248, 204, 219, 246, 44, 145, 158, 16, 118, 137>>
      }
    end

    test "new/1", %{signer: signer, type: sponsorship_type} do
      %RevokeSponsorshipOp{value: ^signer, type: ^sponsorship_type} =
        RevokeSponsorshipOp.new(signer, sponsorship_type)
    end

    test "encode_xdr/1", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      {:ok, ^binary} = RevokeSponsorshipOp.encode_xdr(revoke_sponsorship)
    end

    test "encode_xdr!/1", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      ^binary = RevokeSponsorshipOp.encode_xdr!(revoke_sponsorship)
    end

    test "decode_xdr/2", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      {:ok, {^revoke_sponsorship, ""}} = RevokeSponsorshipOp.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{revoke_sponsorship: revoke_sponsorship, binary: binary} do
      {^revoke_sponsorship, ^binary} = RevokeSponsorshipOp.decode_xdr!(binary <> binary)
    end
  end
end
