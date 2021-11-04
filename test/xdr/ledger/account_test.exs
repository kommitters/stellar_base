defmodule StellarBase.XDR.Ledger.AccountTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, PublicKey, PublicKeyType, UInt256}

  alias StellarBase.XDR.Ledger.Account

  describe "Ledger Account" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StellarBase.Ed25519.PublicKey.decode!()
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      %{
        account_id: account_id,
        account: Account.new(account_id),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119>>
      }
    end

    test "new/1", %{account_id: account_id} do
      %Account{account_id: ^account_id} = Account.new(account_id)
    end

    test "encode_xdr/1", %{account: account, binary: binary} do
      {:ok, ^binary} = Account.encode_xdr(account)
    end

    test "encode_xdr!/1", %{account: account, binary: binary} do
      ^binary = Account.encode_xdr!(account)
    end

    test "decode_xdr/2", %{account: account, binary: binary} do
      {:ok, {^account, ""}} = Account.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Account.decode_xdr(123)
    end

    test "decode_xdr!/2", %{account: account, binary: binary} do
      {^account, ^binary} = Account.decode_xdr!(binary <> binary)
    end
  end
end
