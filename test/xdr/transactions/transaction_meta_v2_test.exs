defmodule StellarBase.XDR.TransactionMetaV2Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractDataDurability,
    ContractDataEntry,
    ContractDataEntryBody,
    ContractEntryBodyType,
    Hash,
    Int64,
    LedgerEntry,
    LedgerEntryChange,
    LedgerEntryChanges,
    LedgerEntryChangeType,
    LedgerEntryData,
    LedgerEntryExt,
    LedgerEntryType,
    OperationMeta,
    OperationMetaList,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    TransactionMetaV2,
    UInt32,
    Void
  }

  describe "TransactionMetaV2" do
    setup do
      tx_changes_before = create_ledger_entry_changes()
      tx_changes_after = create_ledger_entry_changes()
      operation_meta = OperationMeta.new(tx_changes_before)
      operations = OperationMetaList.new([operation_meta])

      %{
        tx_changes_before: tx_changes_before,
        operations: operations,
        tx_changes_after: tx_changes_after,
        transaction_meta_v2:
          TransactionMetaV2.new(tx_changes_before, operations, tx_changes_after),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90,
            80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79,
            83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,
            0, 132, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0,
            0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67,
            87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0,
            0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 132, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0,
            0, 0, 6, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75,
            70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 132, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      tx_changes_before: tx_changes_before,
      operations: operations,
      tx_changes_after: tx_changes_after
    } do
      %TransactionMetaV2{
        tx_changes_before: ^tx_changes_before,
        operations: ^operations,
        tx_changes_after: ^tx_changes_after
      } = TransactionMetaV2.new(tx_changes_before, operations, tx_changes_after)
    end

    test "encode_xdr/1", %{transaction_meta_v2: transaction_meta_v2, binary: binary} do
      {:ok, ^binary} = TransactionMetaV2.encode_xdr(transaction_meta_v2)
    end

    test "encode_xdr!/1", %{transaction_meta_v2: transaction_meta_v2, binary: binary} do
      ^binary = TransactionMetaV2.encode_xdr!(transaction_meta_v2)
    end

    test "decode_xdr/2", %{transaction_meta_v2: transaction_meta_v2, binary: binary} do
      {:ok, {^transaction_meta_v2, ""}} = TransactionMetaV2.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TransactionMetaV2.decode_xdr(123)
    end

    test "decode_xdr!/2", %{transaction_meta_v2: transaction_meta_v2, binary: binary} do
      {^transaction_meta_v2, ^binary} = TransactionMetaV2.decode_xdr!(binary <> binary)
    end
  end

  @spec create_ledger_entry_changes() :: SponsorshipDescriptorList.t()
  defp create_ledger_entry_changes do
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

    ledger_entry_change =
      LedgerEntryChange.new(created_ledger_entry, %LedgerEntryChangeType{
        identifier: :LEDGER_ENTRY_CREATED
      })

    entry_changes = [ledger_entry_change]

    LedgerEntryChanges.new(entry_changes)
  end
end
