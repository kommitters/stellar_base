defmodule StellarBase.XDR.ContractDataEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractDataEntry,
    ContractDataDurability,
    ExtensionPoint,
    Hash,
    Int64,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    Void
  }

  describe "ContractDataEntry" do
    setup do
      address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
      void = Void.new()
      ext = ExtensionPoint.new(void, 0)
      durability = ContractDataDurability.new()
      contract = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))
      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      val = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))

      %{
        ext: ext,
        contract: contract,
        key: key,
        durability: durability,
        val: val,
        contract_data_entry: ContractDataEntry.new(ext, contract, key, durability, val),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70,
            75, 70, 79, 52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0,
            0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{
      ext: ext,
      contract: contract,
      key: key,
      durability: durability,
      val: val
    } do
      %ContractDataEntry{
        ext: ^ext,
        contract: ^contract,
        key: ^key,
        durability: ^durability,
        val: ^val
      } = ContractDataEntry.new(ext, contract, key, durability, val)
    end

    test "encode_xdr/1", %{contract_data_entry: contract_data_entry, binary: binary} do
      {:ok, ^binary} = ContractDataEntry.encode_xdr(contract_data_entry)
    end

    test "encode_xdr!/1", %{contract_data_entry: contract_data_entry, binary: binary} do
      ^binary = ContractDataEntry.encode_xdr!(contract_data_entry)
    end

    test "decode_xdr/2", %{contract_data_entry: contract_data_entry, binary: binary} do
      {:ok, {^contract_data_entry, ""}} = ContractDataEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractDataEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{contract_data_entry: contract_data_entry, binary: binary} do
      {^contract_data_entry, ^binary} = ContractDataEntry.decode_xdr!(binary <> binary)
    end
  end
end
