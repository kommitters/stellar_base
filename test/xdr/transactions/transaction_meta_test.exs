defmodule StellarBase.XDR.TransactionMetaTest do
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
    OperationMeta,
    OperationMetaList,
    OptionalHash,
    OptionalSorobanTransactionMeta,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    SCValType,
    SCValList,
    SorobanTransactionMeta,
    TransactionMeta,
    TransactionMetaV3,
    UInt32,
    Void
  }

  describe "TransactionMeta" do
    setup do
      extension_point_type = 0
      void = Void.new()
      ext = ExtensionPoint.new(void, extension_point_type)
      tx_changes_before = create_ledger_entry_changes()
      tx_changes_after = create_ledger_entry_changes()
      operation_meta = OperationMeta.new(tx_changes_before)
      operations = OperationMetaList.new([operation_meta])
      soroban_meta = create_soroban_meta()

      transaction_meta_v3 =
        TransactionMetaV3.new(
          ext,
          tx_changes_before,
          operations,
          tx_changes_after,
          soroban_meta
        )

      %{
        transaction_meta_v3: transaction_meta_v3,
        transaction_meta: TransactionMeta.new(transaction_meta_v3, 3),
        binary:
          <<0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52,
            67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,
            1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90,
            80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79,
            83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0,
            0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0,
            0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79,
            52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6,
            0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0,
            0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3>>
      }
    end

    test "new/1", %{transaction_meta_v3: transaction_meta_v3} do
      %TransactionMeta{
        value: ^transaction_meta_v3,
        type: 3
      } = TransactionMeta.new(transaction_meta_v3, 3)
    end

    test "encode_xdr/1", %{transaction_meta: transaction_meta, binary: binary} do
      {:ok, ^binary} = TransactionMeta.encode_xdr(transaction_meta)
    end

    test "encode_xdr!/1", %{transaction_meta: transaction_meta, binary: binary} do
      ^binary = TransactionMeta.encode_xdr!(transaction_meta)
    end

    test "decode_xdr/2", %{transaction_meta: transaction_meta, binary: binary} do
      {:ok, {^transaction_meta, ""}} = TransactionMeta.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TransactionMeta.decode_xdr(123)
    end

    test "decode_xdr!/2", %{transaction_meta: transaction_meta, binary: binary} do
      {^transaction_meta, ^binary} = TransactionMeta.decode_xdr!(binary <> binary)
    end
  end

  @spec create_ledger_entry_changes() :: SponsorshipDescriptorList.t()
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

  defp create_soroban_meta do
    contract_id = OptionalHash.new()

    extension_point_type = 0
    void = Void.new()
    ext = ExtensionPoint.new(void, extension_point_type)

    type = ContractEventType.new()

    scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
    scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
    sc_vals = [scval1, scval2]
    topics = SCValList.new(sc_vals)
    data = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
    contract_event_v0 = ContractEventV0.new(topics, data)
    body = ContractEventBody.new(contract_event_v0, 0)
    event = ContractEvent.new(ext, contract_id, type, body)
    events = ContractEventList.new([event])

    in_successful_contract_call = Bool.new(true)
    diagnostic_event = DiagnosticEvent.new(in_successful_contract_call, event)
    diagnostic_events = DiagnosticEventList.new([diagnostic_event])

    return_value = SCVal.new(Int64.new(100), SCValType.new(:SCV_I64))

    soroban_transaction_meta =
      SorobanTransactionMeta.new(ext, events, return_value, diagnostic_events)

    OptionalSorobanTransactionMeta.new(soroban_transaction_meta)
  end
end
