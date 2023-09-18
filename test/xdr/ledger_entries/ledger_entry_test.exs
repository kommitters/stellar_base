defmodule StellarBase.XDR.LedgerEntryTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    ContractDataEntry,
    ContractDataEntry,
    ContractDataDurability,
    Ext,
    ExtensionPoint,
    LedgerEntry,
    OptionalAccountID,
    SponsorshipDescriptor,
    LedgerEntryExtensionV1,
    UInt32,
    Int64,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    LedgerEntryType,
    LedgerEntryExt,
    LedgerEntryData,
    Hash,
    Void
  }

  describe "LedgerEntry" do
    setup do
      account_id =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> create_account_id()
        |> OptionalAccountID.new()

      ext = Ext.new()
      sponsoring_id = SponsorshipDescriptor.new(account_id)
      last_modified_ledger_seq = UInt32.new(5)

      address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
      contract = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))
      durability = ContractDataDurability.new()
      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      val = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      ledger_entry_type = LedgerEntryType.new(:CONTRACT_DATA)
      void = Void.new()
      extension_point = ExtensionPoint.new(void, 0)

      ledger_entry_data = ContractDataEntry.new(extension_point, contract, key, durability, val)

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
          <<0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78,
            82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88,
            81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 1, 0, 0, 0, 0>>,
          <<0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78,
            82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88,
            81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207,
            158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56,
            34, 114, 247, 89, 216, 0, 0, 0, 0>>
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
              ledger_entry_ext: ^ledger_entry_ext
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
