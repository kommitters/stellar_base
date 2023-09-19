defmodule StellarBase.XDR.ContractEventListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractEvent,
    ContractEventBody,
    ContractEventList,
    ContractEventType,
    ContractEventV0,
    ExtensionPoint,
    Int64,
    OptionalHash,
    SCVal,
    SCValType,
    SCValList,
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
      topics = SCValList.new(sc_vals)
      data = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      contract_event_v0 = ContractEventV0.new(topics, data)
      body = ContractEventBody.new(contract_event_v0, 0)
      contract_event = ContractEvent.new(ext, contract_id, type, body)

      %{
        contract_event: contract_event,
        contract_event_list: ContractEventList.new([contract_event]),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0,
            0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 3>>
      }
    end

    test "new/1", %{contract_event: contract_event} do
      items = [contract_event]

      %ContractEventList{
        items: ^items
      } = ContractEventList.new(items)
    end

    test "encode_xdr/1", %{contract_event_list: contract_event_list, binary: binary} do
      {:ok, ^binary} = ContractEventList.encode_xdr(contract_event_list)
    end

    test "encode_xdr!/1", %{contract_event_list: contract_event_list, binary: binary} do
      ^binary = ContractEventList.encode_xdr!(contract_event_list)
    end

    test "decode_xdr/2", %{contract_event_list: contract_event_list, binary: binary} do
      {:ok, {^contract_event_list, ""}} = ContractEventList.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractEventList.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_event_list: contract_event_list, binary: binary} do
      {^contract_event_list, ^binary} = ContractEventList.decode_xdr!(binary <> binary)
    end
  end
end
