defmodule StellarBase.XDR.OperationMetaListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ExtensionPoint,
    OperationMetaList,
    OperationMeta,
    LedgerEntryChange,
    LedgerEntryChanges,
    LedgerEntryChangeType,
    UInt32,
    ContractDataEntry,
    SCAddress,
    SCAddressType,
    Hash,
    ContractDataDurability,
    Int64,
    SCVal,
    SCValType,
    LedgerEntryType,
    Void,
    LedgerEntryExt,
    LedgerEntryData,
    LedgerEntry
  }

  setup do
    ledger_entry_type = LedgerEntryType.new(:CONTRACT_DATA)
    address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
    durability = ContractDataDurability.new()
    key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
    val = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
    last_modified_ledger_seq = UInt32.new(5)
    contract = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))
    void = Void.new()
    ext = ExtensionPoint.new(void, 0)

    ledger_entry_data = ContractDataEntry.new(ext, contract, key, durability, val)

    data = LedgerEntryData.new(ledger_entry_data, ledger_entry_type)

    ledger_entry_ext_data = %{type: 0, value: Void.new()}

    ledger_entry_ext = LedgerEntryExt.new(ledger_entry_ext_data.value, ledger_entry_ext_data.type)

    created_ledger_entry = LedgerEntry.new(last_modified_ledger_seq, data, ledger_entry_ext)

    ledger_entry_change =
      LedgerEntryChange.new(created_ledger_entry, %LedgerEntryChangeType{
        identifier: :LEDGER_ENTRY_CREATED
      })

    ledger_entry_changes = LedgerEntryChanges.new([ledger_entry_change])

    operation_meta = OperationMeta.new(ledger_entry_changes)

    binary =
      <<0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 67,
        65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84,
        53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
        0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0>>

    operation_meta_list = OperationMetaList.new([operation_meta])

    %{
      operation_meta_list: operation_meta_list,
      binary: binary,
      operation_meta_list_items: [operation_meta]
    }
  end

  test "new/1", %{operation_meta_list_items: operation_meta_list_items} do
    %StellarBase.XDR.OperationMetaList{items: ^operation_meta_list_items} =
      OperationMetaList.new(operation_meta_list_items)
  end

  test "encode_xdr/1", %{operation_meta_list_items: operation_meta_list_items, binary: binary} do
    {:ok, ^binary} =
      OperationMetaList.new(operation_meta_list_items) |> OperationMetaList.encode_xdr()
  end

  test "encode_xdr!/1", %{operation_meta_list_items: operation_meta_list_items, binary: binary} do
    ^binary =
      OperationMetaList.new(operation_meta_list_items)
      |> OperationMetaList.encode_xdr!()
  end

  test "decode_xdr/2", %{operation_meta_list: operation_meta_list, binary: binary} do
    {:ok, {^operation_meta_list, ""}} = OperationMetaList.decode_xdr(binary)
  end

  test "decode_xdr!/2", %{operation_meta_list: operation_meta_list, binary: binary} do
    {^operation_meta_list, ""} = OperationMetaList.decode_xdr!(binary)
  end

  test "decode_xdr/2 with invalid binary" do
    {:error, :not_binary} = OperationMetaList.decode_xdr(123)
  end
end
