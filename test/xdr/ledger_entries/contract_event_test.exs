defmodule StellarBase.XDR.ContractEventTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractEvent,
    ContractEventBody,
    ContractEventType,
    ContractEventV0,
    ExtensionPoint,
    Int64,
    OptionalHash,
    SCVal,
    SCValType,
    SCVec,
    Void
  }

  describe "ContractEvent" do
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

      %{
        ext: ext,
        contract_id: contract_id,
        type: type,
        body: body,
        contract_event: ContractEvent.new(ext, contract_id, type, body),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3>>
      }
    end

    test "new/1", %{
      ext: ext,
      contract_id: contract_id,
      type: type,
      body: body
    } do
      %ContractEvent{
        ext: ^ext,
        contract_id: ^contract_id,
        type: ^type,
        body: ^body
      } = ContractEvent.new(ext, contract_id, type, body)
    end

    test "encode_xdr/1", %{contract_event: contract_event, binary: binary} do
      {:ok, ^binary} = ContractEvent.encode_xdr(contract_event)
    end

    test "encode_xdr!/1", %{contract_event: contract_event, binary: binary} do
      ^binary = ContractEvent.encode_xdr!(contract_event)
    end

    test "decode_xdr/2", %{contract_event: contract_event, binary: binary} do
      {:ok, {^contract_event, ""}} = ContractEvent.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractEvent.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_event: contract_event, binary: binary} do
      {^contract_event, ^binary} = ContractEvent.decode_xdr!(binary <> binary)
    end
  end
end
