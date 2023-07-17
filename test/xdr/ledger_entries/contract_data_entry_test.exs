defmodule StellarBase.XDR.ContractDataEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractDataEntry,
    ContractDataEntryBody,
    ContractDataDurability,
    ContractEntryBodyType,
    Hash,
    Int64,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType,
    UInt32,
    Void
  }

  describe "ContractDataEntry" do
    setup do
      address = Hash.new("CAWIIZPXNRY7X3FKFO4CWJT5DQOSEXQK")
      durability = ContractDataDurability.new()

      body =
        ContractDataEntryBody.new(Void.new(), ContractEntryBodyType.new(:EXPIRATION_EXTENSION))

      expiration_ledger_seq = UInt32.new(132)
      contract = SCAddress.new(address, SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT))
      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))

      %{
        contract: contract,
        key: key,
        durability: durability,
        body: body,
        expiration_ledger_seq: expiration_ledger_seq,
        contract_data_entry:
          ContractDataEntry.new(contract, key, durability, body, expiration_ledger_seq),
        binary:
          <<0, 0, 0, 1, 67, 65, 87, 73, 73, 90, 80, 88, 78, 82, 89, 55, 88, 51, 70, 75, 70, 79,
            52, 67, 87, 74, 84, 53, 68, 81, 79, 83, 69, 88, 81, 75, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 132>>
      }
    end

    test "new/1", %{
      contract: contract,
      key: key,
      durability: durability,
      body: body,
      expiration_ledger_seq: expiration_ledger_seq
    } do
      %ContractDataEntry{
        contract: ^contract,
        key: ^key,
        durability: ^durability,
        body: ^body,
        expiration_ledger_seq: ^expiration_ledger_seq
      } = ContractDataEntry.new(contract, key, durability, body, expiration_ledger_seq)
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
