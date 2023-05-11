defmodule StellarBase.XDR.LedgerKeyAccountTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, PublicKey, PublicKeyType, Uint256}

  alias StellarBase.XDR.LedgerKeyAccount

  alias StellarBase.StrKey

  describe "Ledger Account" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      %{
        account_id: account_id,
        account: LedgerKeyAccount.new(account_id),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119>>
      }
    end

    test "new/1", %{account_id: account_id} do
      %LedgerKeyAccount{account_id: ^account_id} = LedgerKeyAccount.new(account_id)
    end

    test "encode_xdr/1", %{account: account, binary: binary} do
      {:ok, ^binary} = LedgerKeyAccount.encode_xdr(account)
    end

    test "encode_xdr!/1", %{account: account, binary: binary} do
      ^binary = LedgerKeyAccount.encode_xdr!(account)
    end

    test "decode_xdr/2", %{account: account, binary: binary} do
      {:ok, {^account, ""}} = LedgerKeyAccount.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyAccount.decode_xdr(123)
    end

    test "decode_xdr!/2", %{account: account, binary: binary} do
      {^account, ^binary} = LedgerKeyAccount.decode_xdr!(binary <> binary)
    end
  end
end
