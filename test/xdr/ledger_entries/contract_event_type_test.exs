defmodule StellarBase.XDR.ContractEventTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractEventType

  describe "ContractEventType" do
    setup do
      types = [:SYSTEM, :CONTRACT, :DIAGNOSTIC]

      %{
        types: types,
        contract_event_type: ContractEventType.new(),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1 default" do
      identifier = :SYSTEM

      %ContractEventType{
        identifier: ^identifier
      } = ContractEventType.new()
    end

    test "new/1", %{
      types: types
    } do
      for type <- types do
        %ContractEventType{
          identifier: ^type
        } = ContractEventType.new(type)
      end
    end

    test "encode_xdr/1", %{contract_event_type: contract_event_type, binary: binary} do
      {:ok, ^binary} = ContractEventType.encode_xdr(contract_event_type)
    end

    test "encode_xdr!/1", %{contract_event_type: contract_event_type, binary: binary} do
      ^binary = ContractEventType.encode_xdr!(contract_event_type)
    end

    test "decode_xdr/2", %{contract_event_type: contract_event_type, binary: binary} do
      {:ok, {^contract_event_type, ""}} = ContractEventType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractEventType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_event_type: contract_event_type, binary: binary} do
      {^contract_event_type, ^binary} = ContractEventType.decode_xdr!(binary <> binary)
    end
  end
end
