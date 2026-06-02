defmodule StellarBase.XDR.TransactionMetaV4Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Bool,
    ExtensionPoint,
    ContractDataDurability,
    ContractDataEntry,
    ContractEvent,
    ContractEventBody,
    ContractEventList,
    ContractEventType,
    ContractEventV0,
    DiagnosticEvent,
    DiagnosticEventList,
    Hash,
    Int64,
    LedgerEntry,
    LedgerEntryChange,
    LedgerEntryChanges,
    LedgerEntryChangeType,
    LedgerEntryData,
    LedgerEntryExt,
    LedgerEntryType,
    OperationMetaV2,
    OperationMetaV2List,
    OptionalHash,
    OptionalSorobanTransactionMetaV2,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    SCValList,
    SorobanTransactionMetaV2,
    SorobanTransactionMetaExt,
    OptionalSCVal,
    TransactionEventStage,
    TransactionEvent,
    TransactionEventList,
    TransactionMetaV4,
    UInt32,
    Void
  }

  describe "TransactionMetaV4" do
    setup do
      extension_point_type = 0
      void = Void.new()
      ext = ExtensionPoint.new(void, extension_point_type)
      tx_changes_before = create_ledger_entry_changes()
      tx_changes_after = create_ledger_entry_changes()

      contract_id = OptionalHash.new()
      type = ContractEventType.new()
      topics = SCValList.new([SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))])
      data = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      contract_event_v0 = ContractEventV0.new(topics, data)
      body = ContractEventBody.new(contract_event_v0, 0)
      event = ContractEvent.new(ext, contract_id, type, body)
      events_list = ContractEventList.new([event])

      operation_meta = OperationMetaV2.new(ext, tx_changes_before, events_list)
      operations = OperationMetaV2List.new([operation_meta])

      soroban_meta = create_soroban_meta()

      stage = TransactionEventStage.new()
      tx_event = TransactionEvent.new(stage, event)
      tx_events = TransactionEventList.new([tx_event])

      in_successful_contract_call = Bool.new(true)
      diagnostic_event = DiagnosticEvent.new(in_successful_contract_call, event)
      diagnostic_events = DiagnosticEventList.new([diagnostic_event])

      %{
        ext: ext,
        tx_changes_before: tx_changes_before,
        operations: operations,
        tx_changes_after: tx_changes_after,
        soroban_meta: soroban_meta,
        events: tx_events,
        diagnostic_events: diagnostic_events,
        transaction_meta_v4:
          TransactionMetaV4.new(
            ext,
            tx_changes_before,
            operations,
            tx_changes_after,
            soroban_meta,
            tx_events,
            diagnostic_events
          )
      }
    end

    test "new/7", %{
      ext: ext,
      tx_changes_before: tx_changes_before,
      operations: operations,
      tx_changes_after: tx_changes_after,
      soroban_meta: soroban_meta,
      events: events,
      diagnostic_events: diagnostic_events
    } do
      %TransactionMetaV4{
        ext: ^ext,
        tx_changes_before: ^tx_changes_before,
        operations: ^operations,
        tx_changes_after: ^tx_changes_after,
        soroban_meta: ^soroban_meta,
        events: ^events,
        diagnostic_events: ^diagnostic_events
      } =
        TransactionMetaV4.new(
          ext,
          tx_changes_before,
          operations,
          tx_changes_after,
          soroban_meta,
          events,
          diagnostic_events
        )
    end

    test "encode and decode", %{transaction_meta_v4: transaction_meta_v4} do
      encoded = TransactionMetaV4.encode_xdr!(transaction_meta_v4)
      {decoded, ""} = TransactionMetaV4.decode_xdr!(encoded)
      assert decoded == transaction_meta_v4
    end
  end

  defp create_ledger_entry_changes do
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
    ledger_entry_ext = LedgerEntryExt.new(Void.new(), 0)
    created_ledger_entry = LedgerEntry.new(last_modified_ledger_seq, data, ledger_entry_ext)

    ledger_entry_change =
      LedgerEntryChange.new(created_ledger_entry, %LedgerEntryChangeType{
        identifier: :LEDGER_ENTRY_CREATED
      })

    LedgerEntryChanges.new([ledger_entry_change])
  end

  defp create_soroban_meta do
    void = Void.new()
    soroban_tx_ext = SorobanTransactionMetaExt.new(void, 0)
    return_value = OptionalSCVal.new(SCVal.new(Int64.new(100), SCValType.new(:SCV_I64)))
    soroban_transaction_meta_v2 = SorobanTransactionMetaV2.new(soroban_tx_ext, return_value)
    OptionalSorobanTransactionMetaV2.new(soroban_transaction_meta_v2)
  end
end
