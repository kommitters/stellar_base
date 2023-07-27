defmodule StellarBase.XDR.ContractEventBodyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractEventBody,
    ContractEventV0,
    Int64,
    SCVal,
    SCValType,
    SCVec
  }

  describe "ContractEventBody" do
    setup do
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      topics = SCVec.new(sc_vals)
      data = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      contract_event_v0 = ContractEventV0.new(topics, data)

      %{
        topics: topics,
        data: data,
        type: 0,
        contract_event_v0: contract_event_v0,
        contract_event_body: ContractEventBody.new(contract_event_v0, 0),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0,
            0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3>>
      }
    end

    test "new/1", %{
      type: type,
      contract_event_v0: contract_event_v0
    } do
      %ContractEventBody{
        type: ^type,
        value: ^contract_event_v0
      } = ContractEventBody.new(contract_event_v0, type)
    end

    test "encode_xdr/1", %{contract_event_body: contract_event_body, binary: binary} do
      {:ok, ^binary} = ContractEventBody.encode_xdr(contract_event_body)
    end

    test "encode_xdr!/1", %{contract_event_body: contract_event_body, binary: binary} do
      ^binary = ContractEventBody.encode_xdr!(contract_event_body)
    end

    test "decode_xdr/2", %{contract_event_body: contract_event_body, binary: binary} do
      {:ok, {^contract_event_body, ""}} = ContractEventBody.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractEventBody.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_event_body: contract_event_body, binary: binary} do
      {^contract_event_body, ^binary} = ContractEventBody.decode_xdr!(binary <> binary)
    end
  end
end
