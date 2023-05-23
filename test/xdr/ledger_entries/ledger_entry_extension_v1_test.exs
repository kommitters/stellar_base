defmodule StellarBase.XDR.LedgerEntryExtensionV1Test do
  use ExUnit.Case

  import StellarBase.Test.Utils, only: [create_account_id: 1]

  alias StellarBase.XDR.{
    SponsorshipDescriptor,
    LedgerEntryExtensionV1Ext,
    LedgerEntryExtensionV1,
    Void
  }

  describe "LedgerEntryExtensionV1" do
    setup do
      account_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> create_account_id()

      sponsoring_id = account_id |> SponsorshipDescriptor.new()
      ext = LedgerEntryExtensionV1Ext.new(Void.new(), 0)
      ledger_entry_extension_v1 = LedgerEntryExtensionV1.new(sponsoring_id, ext)

      %{
        sponsoring_id: sponsoring_id,
        ext: ext,
        ledger_entry_extension_v1: ledger_entry_extension_v1,
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67,
            32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89,
            216, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{sponsoring_id: sponsoring_id, ext: ext} do
      %LedgerEntryExtensionV1{sponsoring_id: ^sponsoring_id, ext: ^ext} =
        LedgerEntryExtensionV1.new(sponsoring_id, ext)
    end

    test "encode_xdr/1", %{ledger_entry_extension_v1: ledger_entry_extension_v1, binary: binary} do
      {:ok, ^binary} = LedgerEntryExtensionV1.encode_xdr(ledger_entry_extension_v1)
    end

    test "encode_xdr!/1", %{ledger_entry_extension_v1: ledger_entry_extension_v1, binary: binary} do
      ^binary = LedgerEntryExtensionV1.encode_xdr!(ledger_entry_extension_v1)
    end

    test "decode_xdr/1", %{ledger_entry_extension_v1: ledger_entry_extension_v1, binary: binary} do
      {:ok, {^ledger_entry_extension_v1, ""}} = LedgerEntryExtensionV1.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = LedgerEntryExtensionV1.decode_xdr(123)
    end

    test "decode_xdr!/1", %{ledger_entry_extension_v1: ledger_entry_extension_v1, binary: binary} do
      {^ledger_entry_extension_v1, ""} = LedgerEntryExtensionV1.decode_xdr!(binary)
    end
  end
end
