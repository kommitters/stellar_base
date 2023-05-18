defmodule StellarBase.XDR.LedgerKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    LedgerKeyContractCode,
    Hash,
    Int64,
    LedgerKeyAccount,
    LedgerEntryType,
    LedgerKey,
    PublicKey,
    PublicKeyType,
    String64,
    Uint256
  }

  alias StellarBase.XDR.{Data, Offer}

  alias StellarBase.StrKey

  setup do
    pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

    account_id =
      "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
      |> StrKey.decode!(:ed25519_public_key)
      |> Uint256.new()
      |> PublicKey.new(pk_type)
      |> AccountID.new()

    offer_id = Int64.new(123_456)
    data_name = String64.new("Test")
    hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

    discriminants = [
      %{
        type: LedgerEntryType.new(:ACCOUNT),
        ledger_key_data: LedgerKeyAccount.new(account_id),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119>>
      },
      %{
        type: LedgerEntryType.new(:OFFER),
        ledger_key_data: Offer.new(account_id, offer_id),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0, 0, 1, 226, 64>>
      },
      %{
        type: LedgerEntryType.new(:DATA),
        ledger_key_data: Data.new(account_id, data_name),
        binary:
          <<0, 0, 0, 3, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 4, 84, 101, 115, 116>>
      },
      %{
        type: LedgerEntryType.new(:CONTRACT_CODE),
        ledger_key_data: LedgerKeyContractCode.new(hash),
        binary:
          <<0, 0, 0, 7, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    ]

    %{discriminants: discriminants}
  end

  test "new/1", %{discriminants: discriminants} do
    for %{type: type, ledger_key_data: ledger_key_data} <- discriminants do
      %LedgerKey{value: ^ledger_key_data, type: ^type} = LedgerKey.new(ledger_key_data, type)
    end
  end

  test "encode_xdr/1", %{discriminants: discriminants} do
    for %{ledger_key_data: ledger_key_data, type: type, binary: binary} <- discriminants do
      xdr = LedgerKey.new(ledger_key_data, type)
      {:ok, ^binary} = LedgerKey.encode_xdr(xdr)
    end
  end

  test "encode_xdr!/1", %{discriminants: discriminants} do
    for %{ledger_key_data: ledger_key_data, type: type, binary: binary} <- discriminants do
      xdr = LedgerKey.new(ledger_key_data, type)
      ^binary = LedgerKey.encode_xdr!(xdr)
    end
  end

  test "encode_xdr/1 with an invalid type", %{discriminants: [ledger_key_data | _rest]} do
    type = LedgerEntryType.new(:NEW_ADDRESS)

    assert_raise XDR.EnumError,
                 "The key which you try to encode doesn't belong to the current declarations",
                 fn ->
                   ledger_key_data
                   |> LedgerKey.new(type)
                   |> LedgerKey.encode_xdr()
                 end
  end

  test "decode_xdr/2", %{discriminants: discriminants} do
    for %{ledger_key_data: ledger_key_data, type: type, binary: binary} <- discriminants do
      xdr = LedgerKey.new(ledger_key_data, type)
      {:ok, {^xdr, ""}} = LedgerKey.decode_xdr(binary)
    end
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = LedgerKey.decode_xdr(123)
  end

  test "decode_xdr!/2", %{discriminants: discriminants} do
    for %{ledger_key: ledger_key, type: type, binary: binary} <- discriminants do
      xdr = LedgerKey.new(ledger_key, type)
      {^xdr, ""} = LedgerKey.decode_xdr!(binary)
    end
  end
end
