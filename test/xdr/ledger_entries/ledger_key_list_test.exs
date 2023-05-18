defmodule StellarBase.XDR.LedgerKeyListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    LedgerKeyAccount,
    AccountID,
    LedgerEntryType,
    LedgerKey,
    LedgerKeyList,
    PublicKey,
    PublicKeyType,
    Uint256
  }

  alias StellarBase.StrKey

  describe "LedgerKeyListTest" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      type = LedgerEntryType.new(:ACCOUNT)
      ledger_key_data = LedgerKeyAccount.new(account_id)

      ledger_keys = [LedgerKey.new(ledger_key_data, type)]

      %{
        ledger_keys: ledger_keys,
        ledger_keys_list: LedgerKeyList.new(ledger_keys),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119>>
      }
    end

    test "new/1", %{ledger_keys: ledger_keys} do
      %LedgerKeyList{items: ^ledger_keys} = LedgerKeyList.new(ledger_keys)
    end

    test "encode_xdr/1", %{ledger_keys: ledger_keys, binary: binary} do
      {:ok, ^binary} = ledger_keys |> LedgerKeyList.new() |> LedgerKeyList.encode_xdr()
    end

    test "encode_xdr!/1", %{ledger_keys: ledger_keys, binary: binary} do
      ^binary = ledger_keys |> LedgerKeyList.new() |> LedgerKeyList.encode_xdr!()
    end

    test "decode_xdr/1", %{ledger_keys_list: ledger_keys_list, binary: binary} do
      {:ok, {^ledger_keys_list, ""}} = LedgerKeyList.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyList.decode_xdr(123)
    end

    test "decode_xdr!/1", %{ledger_keys_list: ledger_keys_list, binary: binary} do
      {^ledger_keys_list, ""} = LedgerKeyList.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> LedgerKeyList.decode_xdr!(123) end
    end
  end
end
