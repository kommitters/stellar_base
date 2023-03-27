defmodule StellarBase.XDR.LedgerFootprintTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Account,
    AccountID,
    LedgerEntryType,
    LedgerFootprint,
    LedgerKey,
    LedgerKeyList,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  alias StellarBase.StrKey

  describe "LedgerFootprint" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      type = LedgerEntryType.new(:ACCOUNT)
      ledger_key_data = Account.new(account_id)

      ledger_keys = [LedgerKey.new(ledger_key_data, type)]

      read_only = LedgerKeyList.new(ledger_keys)
      read_write = LedgerKeyList.new(ledger_keys)

      %{
        read_only: read_only,
        read_write: read_write,
        ledger_footprint: LedgerFootprint.new(read_only, read_write),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186,
            154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25,
            212, 179, 73, 138, 2, 227, 119>>
      }
    end

    test "new/1", %{read_only: read_only, read_write: read_write} do
      %LedgerFootprint{read_only: ^read_only, read_write: ^read_write} =
        LedgerFootprint.new(read_only, read_write)
    end

    test "encode_xdr/1", %{ledger_footprint: ledger_footprint, binary: binary} do
      {:ok, ^binary} = LedgerFootprint.encode_xdr(ledger_footprint)
    end

    test "encode_xdr!/1", %{ledger_footprint: ledger_footprint, binary: binary} do
      ^binary = LedgerFootprint.encode_xdr!(ledger_footprint)
    end

    test "decode_xdr/2", %{ledger_footprint: ledger_footprint, binary: binary} do
      {:ok, {^ledger_footprint, ""}} = LedgerFootprint.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerFootprint.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{ledger_footprint: ledger_footprint, binary: binary} do
      {^ledger_footprint, ""} = LedgerFootprint.decode_xdr!(binary)
    end
  end
end
