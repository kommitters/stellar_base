defmodule StellarBase.XDR.DiagnosticEventTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Bool,
    ContractEvent,
    ContractEventBody,
    ContractEventType,
    ContractEventV0,
    DiagnosticEvent,
    ExtensionPoint,
    Int64,
    OptionalHash,
    SCVal,
    SCValList,
    SCValType,
    Void
  }

  describe "DiagnosticEvent" do
    setup do
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
      in_successful_contract_call = Bool.new(true)

      %{
        event: event,
        in_successful_contract_call: in_successful_contract_call,
        diagnostic_event: DiagnosticEvent.new(in_successful_contract_call, event),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0,
            0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 3>>
      }
    end

    test "new/1", %{
      event: event,
      in_successful_contract_call: in_successful_contract_call
    } do
      %DiagnosticEvent{
        event: ^event,
        in_successful_contract_call: ^in_successful_contract_call
      } = DiagnosticEvent.new(in_successful_contract_call, event)
    end

    test "encode_xdr/1", %{diagnostic_event: diagnostic_event, binary: binary} do
      {:ok, ^binary} = DiagnosticEvent.encode_xdr(diagnostic_event)
    end

    test "encode_xdr!/1", %{diagnostic_event: diagnostic_event, binary: binary} do
      ^binary = DiagnosticEvent.encode_xdr!(diagnostic_event)
    end

    test "decode_xdr/2", %{diagnostic_event: diagnostic_event, binary: binary} do
      {:ok, {^diagnostic_event, ""}} = DiagnosticEvent.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = DiagnosticEvent.decode_xdr(123)
    end

    test "decode_xdr!/2", %{diagnostic_event: diagnostic_event, binary: binary} do
      {^diagnostic_event, ^binary} = DiagnosticEvent.decode_xdr!(binary <> binary)
    end
  end
end
