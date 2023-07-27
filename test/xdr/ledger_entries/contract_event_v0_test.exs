defmodule StellarBase.XDR.ContractEventV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractEventV0,
    Int64,
    SCVal,
    SCValType,
    SCVec
  }

  describe "ContractEventV0" do
    setup do
      scval1 = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))
      scval2 = SCVal.new(Int64.new(2), SCValType.new(:SCV_I64))
      sc_vals = [scval1, scval2]
      topics = SCVec.new(sc_vals)
      data = SCVal.new(Int64.new(3), SCValType.new(:SCV_I64))

      %{
        topics: topics,
        data: data,
        contract_event_v0: ContractEventV0.new(topics, data),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0,
            0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 3>>
      }
    end

    test "new/1", %{
      topics: topics,
      data: data
    } do
      %ContractEventV0{
        topics: ^topics,
        data: ^data
      } = ContractEventV0.new(topics, data)
    end

    test "encode_xdr/1", %{contract_event_v0: contract_event_v0, binary: binary} do
      {:ok, ^binary} = ContractEventV0.encode_xdr(contract_event_v0)
    end

    test "encode_xdr!/1", %{contract_event_v0: contract_event_v0, binary: binary} do
      ^binary = ContractEventV0.encode_xdr!(contract_event_v0)
    end

    test "decode_xdr/2", %{contract_event_v0: contract_event_v0, binary: binary} do
      {:ok, {^contract_event_v0, ""}} = ContractEventV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractEventV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_event_v0: contract_event_v0, binary: binary} do
      {^contract_event_v0, ^binary} = ContractEventV0.decode_xdr!(binary <> binary)
    end
  end
end
