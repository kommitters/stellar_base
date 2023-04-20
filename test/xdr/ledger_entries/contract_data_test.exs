defmodule StellarBase.XDR.ContractDataTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ContractData, SCVal, SCValType, Int64, Hash}

  describe "ContractData" do
    setup do
      contract_id = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))

      %{
        contract_id: contract_id,
        key: key,
        contract_data_entry: ContractData.new(contract_id, key),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{contract_id: contract_id, key: key} do
      %ContractData{contract_id: ^contract_id, key: ^key} = ContractData.new(contract_id, key)
    end

    test "encode_xdr/1", %{contract_data_entry: contract_data_entry, binary: binary} do
      {:ok, ^binary} = ContractData.encode_xdr(contract_data_entry)
    end

    test "encode_xdr!/1", %{contract_data_entry: contract_data_entry, binary: binary} do
      ^binary = ContractData.encode_xdr!(contract_data_entry)
    end

    test "decode_xdr/2", %{contract_data_entry: contract_data_entry, binary: binary} do
      {:ok, {^contract_data_entry, ""}} = ContractData.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractData.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_data_entry: contract_data_entry, binary: binary} do
      {^contract_data_entry, ^binary} = ContractData.decode_xdr!(binary <> binary)
    end
  end
end
