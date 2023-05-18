defmodule StellarBase.XDR.LedgerEntryTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    LedgerEntry,
    OptionalAccountID,
    SponsorshipDescriptor,
    LedgerEntryExtensionV1,
    Uint32,
    Int64,
    SCVal,
    SCValType,
    LedgerEntryType,
    ContractDataEntry,
    LedgerEntryExt,
    LedgerEntryData,
    Hash,
    LedgerEntryExtensionV1Ext,
    Void
  }

  describe "LedgerEntry" do
    setup do
      account_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> create_account_id()
        |> OptionalAccountID.new()

      ext = LedgerEntryExtensionV1Ext.new(Void.new(), 0)
      sponsoring_id = SponsorshipDescriptor.new(account_id)
      last_modified_ledger_seq = Uint32.new(5)

      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      val = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      ledger_entry_type = LedgerEntryType.new(:CONTRACT_DATA)
      ledger_entry_data = ContractDataEntry.new(contract_id, key, val)

      data = LedgerEntryData.new(ledger_entry_data, ledger_entry_type)

      ledger_entry_ext_list =
        [
          %{type: 0, value: Void.new()},
          %{
            type: 1,
            value: LedgerEntryExtensionV1.new(sponsoring_id, ext)
          }
        ]
        |> Enum.map(fn %{type: type, value: value} ->
          LedgerEntryExt.new(value, type)
        end)

      ledger_entry_list =
        ledger_entry_ext_list
        |> Enum.map(fn ledger_entry_ext ->
          LedgerEntry.new(
            last_modified_ledger_seq,
            data,
            ledger_entry_ext
          )
        end)

      %{
        last_modified_ledger_seq: last_modified_ledger_seq,
        data: data,
        ledger_entry_ext_list: ledger_entry_ext_list,
        ledger_entry_list: ledger_entry_list,
        binaries: [
          <<0, 0, 0, 5, 0, 0, 0, 6, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 6, 0, 0,
            0, 0, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0>>,
          <<0, 0, 0, 5, 0, 0, 0, 6, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 6, 0, 0,
            0, 0, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0,
            0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135,
            171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0>>
        ]
      }
    end

    test "new/1", %{
      last_modified_ledger_seq: last_modified_ledger_seq,
      data: data,
      ledger_entry_ext_list: ledger_entry_ext_list
    } do
      for ledger_entry_ext <- ledger_entry_ext_list,
          do:
            %LedgerEntry{
              last_modified_ledger_seq: ^last_modified_ledger_seq,
              data: ^data,
              ext: ^ledger_entry_ext
            } =
              LedgerEntry.new(
                last_modified_ledger_seq,
                data,
                ledger_entry_ext
              )
    end

    test "encode_xdr/1", %{
      ledger_entry_list: ledger_entry_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(ledger_entry_list, binaries),
          do: {:ok, ^binary} = LedgerEntry.encode_xdr(account_entry_extension_v2)
    end

    test "encode_xdr!/1", %{
      ledger_entry_list: ledger_entry_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(ledger_entry_list, binaries),
          do: ^binary = LedgerEntry.encode_xdr!(account_entry_extension_v2)
    end

    test "decode_xdr/1", %{
      ledger_entry_list: ledger_entry_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(ledger_entry_list, binaries),
          do: {:ok, {^account_entry_extension_v2, ""}} = LedgerEntry.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{
      ledger_entry_list: ledger_entry_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2, binary} <-
            Enum.zip(ledger_entry_list, binaries),
          do: {^account_entry_extension_v2, ""} = LedgerEntry.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerEntry.decode_xdr(123)
    end
  end
end
