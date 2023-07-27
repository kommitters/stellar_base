defmodule StellarBase.XDR.SorobanTransactionMetaTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Bool,
    ContractEvent,
    ContractEventBody,
    ContractEventList,
    ContractEventType,
    ContractEventV0,
    DiagnosticEvent,
    DiagnosticEventList,
    ExtensionPoint,
    Int64,
    OptionalHash,
    SCVal,
    SCValType,
    SCVec,
    SorobanTransactionMeta,
    Void
  }

  describe "SorobanTransactionMeta" do
    setup do
      contract_id = OptionalHash.new()

      extension_point_type = 0
      void = Void.new()
      ext = ExtensionPoint.new(void, extension_point_type)

      type = ContractEventType.new()

      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      topics = SCVec.new(sc_vals)
      data = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      contract_event_v0 = ContractEventV0.new(topics, data)
      body = ContractEventBody.new(contract_event_v0, 0)
      event = ContractEvent.new(ext, contract_id, type, body)
      events = ContractEventList.new([event])

      in_successful_contract_call = Bool.new(true)
      diagnostic_event = DiagnosticEvent.new(in_successful_contract_call, event)
      diagnostic_events = DiagnosticEventList.new([diagnostic_event])

      return_value = SCVal.new(Int64.new(100), SCValType.new(:SCV_I64))

      %{
        ext: ext,
        events: events,
        return_value: return_value,
        diagnostic_events: diagnostic_events,
        soroban_transaction_meta:
          SorobanTransactionMeta.new(ext, events, return_value, diagnostic_events),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0,
            0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0,
            3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3>>
      }
    end

    test "new/1", %{
      ext: ext,
      events: events,
      return_value: return_value,
      diagnostic_events: diagnostic_events
    } do
      %SorobanTransactionMeta{
        ext: ^ext,
        events: ^events,
        return_value: ^return_value,
        diagnostic_events: ^diagnostic_events
      } =
        SorobanTransactionMeta.new(
          ext,
          events,
          return_value,
          diagnostic_events
        )
    end

    test "encode_xdr/1", %{soroban_transaction_meta: soroban_transaction_meta, binary: binary} do
      {:ok, ^binary} = SorobanTransactionMeta.encode_xdr(soroban_transaction_meta)
    end

    test "encode_xdr!/1", %{soroban_transaction_meta: soroban_transaction_meta, binary: binary} do
      ^binary = SorobanTransactionMeta.encode_xdr!(soroban_transaction_meta)
    end

    test "decode_xdr/2", %{soroban_transaction_meta: soroban_transaction_meta, binary: binary} do
      {:ok, {^soroban_transaction_meta, ""}} = SorobanTransactionMeta.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SorobanTransactionMeta.decode_xdr(123)
    end

    test "decode_xdr!/2", %{soroban_transaction_meta: soroban_transaction_meta, binary: binary} do
      {^soroban_transaction_meta, ^binary} = SorobanTransactionMeta.decode_xdr!(binary <> binary)
    end
  end
end
