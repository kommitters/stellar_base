defmodule StellarBase.XDR.LedgerEntryChangeTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    LedgerEntryData,
    LedgerEntryChange,
    LedgerEntry,
    LedgerEntryChangeType,
    UInt32,
    ContractDataEntry,
    ContractDataEntryBody,
    ContractEntryBodyType,
    SCAddress,
    SCAddressType,
    Hash,
    ContractDataDurability,
    Int64,
    SCVal,
    SCValType,
    LedgerEntryType,
    Void,
    LedgerEntryExt
  }

  setup do
    ledger_entry_type = LedgerEntryType.new(:CONTRACT_DATA)
    expiration_ledger_seq = UInt32.new(132)
    address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
    durability = ContractDataDurability.new()
    key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
    last_modified_ledger_seq = UInt32.new(5)
    contract = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))

    body = ContractDataEntryBody.new(Void.new(), ContractEntryBodyType.new(:EXPIRATION_EXTENSION))

    ledger_entry_data =
      ContractDataEntry.new(contract, key, durability, body, expiration_ledger_seq)

    data = LedgerEntryData.new(ledger_entry_data, ledger_entry_type)

    ledger_entry_ext_data = %{type: 0, value: Void.new()}

    ledger_entry_ext = LedgerEntryExt.new(ledger_entry_ext_data.value, ledger_entry_ext_data.type)

    created_ledger_entry = LedgerEntry.new(last_modified_ledger_seq, data, ledger_entry_ext)
    type = LedgerEntryChangeType.new()

    binary =
      <<0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82,
        89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0,
        0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 132, 0, 0, 0, 0>>

    ledger_entry_change =
      LedgerEntryChange.new(created_ledger_entry, %LedgerEntryChangeType{
        identifier: :LEDGER_ENTRY_CREATED
      })

    %{
      created_ledger_entry: created_ledger_entry,
      type: type,
      binary: binary,
      ledger_entry_change: ledger_entry_change
    }
  end

  test "new/1 with LEDGER_ENTRY_CREATED", %{
    created_ledger_entry: created_ledger_entry,
    type: type
  } do
    %StellarBase.XDR.LedgerEntryChange{
      value: ^created_ledger_entry,
      type: ^type
    } =
      LedgerEntryChange.new(created_ledger_entry, %LedgerEntryChangeType{
        identifier: :LEDGER_ENTRY_CREATED
      })
  end

  test "encode_xdr/1", %{created_ledger_entry: created_ledger_entry, type: type, binary: binary} do
    {:ok, ^binary} =
      LedgerEntryChange.new(created_ledger_entry, type) |> LedgerEntryChange.encode_xdr()
  end

  test "encode_xdr!/1", %{created_ledger_entry: created_ledger_entry, type: type, binary: binary} do
    ^binary = LedgerEntryChange.new(created_ledger_entry, type) |> LedgerEntryChange.encode_xdr!()
  end

  test "decode_xdr/2", %{ledger_entry_change: ledger_entry_change, binary: binary} do
    {:ok, {^ledger_entry_change, ""}} = LedgerEntryChange.decode_xdr(binary)
  end

  test "decode_xdr!/2", %{ledger_entry_change: ledger_entry_change, binary: binary} do
    {^ledger_entry_change, ""} = LedgerEntryChange.decode_xdr!(binary)
  end

  test "decode_xdr/2 with invalid binary" do
    {:error, :not_binary} = LedgerEntryChange.decode_xdr(123)
  end
end
