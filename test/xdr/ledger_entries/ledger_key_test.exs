defmodule StellarBase.XDR.LedgerKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    Int64,
    LedgerEntryType,
    LedgerKey,
    PublicKey,
    PublicKeyType,
    String64,
    UInt256
  }

  alias StellarBase.XDR.{Account, Data, Offer}

  alias StellarBase.StrKey

  setup do
    pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

    account_id =
      "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      |> StrKey.decode!(:ed25519_public_key)
      |> UInt256.new()
      |> PublicKey.new(pk_type)
      |> AccountID.new()

    {:ok, %{account_id: account_id}}
  end

  describe "Account Entry" do
    setup %{account_id: account_id} do
      entry_type = LedgerEntryType.new(:ACCOUNT)
      account = Account.new(account_id)

      %{
        account: account,
        entry_type: entry_type,
        ledger_key: LedgerKey.new(account, entry_type),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119>>
      }
    end

    test "new/1", %{account: account, entry_type: entry_type} do
      %LedgerKey{type: ^entry_type} = LedgerKey.new(account, entry_type)
    end

    test "encode_xdr/1", %{ledger_key: ledger_key, binary: binary} do
      {:ok, ^binary} = LedgerKey.encode_xdr(ledger_key)
    end

    test "encode_xdr!/1", %{ledger_key: ledger_key, binary: binary} do
      ^binary = LedgerKey.encode_xdr!(ledger_key)
    end

    test "decode_xdr/2", %{ledger_key: ledger_key, binary: binary} do
      {:ok, {^ledger_key, ""}} = LedgerKey.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{ledger_key: ledger_key, binary: binary} do
      {^ledger_key, ^binary} = LedgerKey.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKey.decode_xdr(123)
    end

    test "invalid identifier", %{account: account} do
      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     account
                     |> LedgerKey.new(LedgerEntryType.new(:TEST))
                     |> LedgerKey.encode_xdr()
                   end
    end
  end

  describe "Offer Entry" do
    setup %{account_id: account_id} do
      entry_type = LedgerEntryType.new(:OFFER)
      offer_id = Int64.new(123_456)
      offer = Offer.new(account_id, offer_id)

      %{
        offer: offer,
        entry_type: entry_type,
        ledger_key: LedgerKey.new(offer, entry_type),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 0, 1, 226, 64>>
      }
    end

    test "new/1", %{offer: offer, entry_type: entry_type} do
      %LedgerKey{type: ^entry_type} = LedgerKey.new(offer, entry_type)
    end

    test "encode_xdr/1", %{ledger_key: ledger_key, binary: binary} do
      {:ok, ^binary} = LedgerKey.encode_xdr(ledger_key)
    end

    test "encode_xdr!/1", %{ledger_key: ledger_key, binary: binary} do
      ^binary = LedgerKey.encode_xdr!(ledger_key)
    end

    test "decode_xdr/2", %{ledger_key: ledger_key, binary: binary} do
      {:ok, {^ledger_key, ""}} = LedgerKey.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{ledger_key: ledger_key, binary: binary} do
      {^ledger_key, ^binary} = LedgerKey.decode_xdr!(binary <> binary)
    end
  end

  describe "Data Entry" do
    setup %{account_id: account_id} do
      entry_type = LedgerEntryType.new(:DATA)
      data_name = String64.new("Test")
      data = Data.new(account_id, data_name)

      %{
        data: data,
        entry_type: entry_type,
        ledger_key: LedgerKey.new(data, entry_type),
        binary:
          <<0, 0, 0, 3, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 4, 84, 101, 115, 116>>
      }
    end

    test "new/1", %{data: data, entry_type: entry_type} do
      %LedgerKey{type: ^entry_type} = LedgerKey.new(data, entry_type)
    end

    test "encode_xdr/1", %{ledger_key: ledger_key, binary: binary} do
      {:ok, ^binary} = LedgerKey.encode_xdr(ledger_key)
    end

    test "encode_xdr!/1", %{ledger_key: ledger_key, binary: binary} do
      ^binary = LedgerKey.encode_xdr!(ledger_key)
    end

    test "decode_xdr/2", %{ledger_key: ledger_key, binary: binary} do
      {:ok, {^ledger_key, ""}} = LedgerKey.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{ledger_key: ledger_key, binary: binary} do
      {^ledger_key, ^binary} = LedgerKey.decode_xdr!(binary <> binary)
    end
  end
end
