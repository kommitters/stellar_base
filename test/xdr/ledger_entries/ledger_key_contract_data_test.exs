defmodule StellarBase.XDR.LedgerKeyContractDataTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractDataDurability,
    Hash,
    Int64,
    LedgerKeyContractData,
    SCAddress,
    SCAddressType,
    SCVal,
    SCValType
  }

  describe "LedgerKeyContractData" do
    setup do
      address_type = SCAddressType.new(:SC_ADDRESS_TYPE_CONTRACT)

      contract_address =
        "CBT6AP4HS575FETHYO6CMIZ2NUFPLKC7"
        |> Hash.new()
        |> SCAddress.new(address_type)

      key = SCVal.new(Int64.new(1), SCValType.new(:SCV_I64))
      durability = ContractDataDurability.new(:TEMPORARY)

      %{
        contract_address: contract_address,
        key: key,
        durability: durability,
        ledger_key_contract_data: LedgerKeyContractData.new(contract_address, key, durability),
        binary:
          <<0, 0, 0, 1, 67, 66, 84, 54, 65, 80, 52, 72, 83, 53, 55, 53, 70, 69, 84, 72, 89, 79,
            54, 67, 77, 73, 90, 50, 78, 85, 70, 80, 76, 75, 67, 55, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0,
            0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/3", %{
      contract_address: contract_address,
      key: key,
      durability: durability
    } do
      %LedgerKeyContractData{
        contract: ^contract_address,
        key: ^key,
        durability: ^durability
      } =
        LedgerKeyContractData.new(
          contract_address,
          key,
          durability
        )
    end

    test "encode_xdr/1", %{
      ledger_key_contract_data: ledger_key_contract_data,
      binary: binary
    } do
      {:ok, ^binary} = LedgerKeyContractData.encode_xdr(ledger_key_contract_data)
    end

    test "encode_xdr!/1", %{
      ledger_key_contract_data: ledger_key_contract_data,
      binary: binary
    } do
      ^binary = LedgerKeyContractData.encode_xdr!(ledger_key_contract_data)
    end

    test "decode_xdr/2", %{
      ledger_key_contract_data: ledger_key_contract_data,
      binary: binary
    } do
      {:ok, {^ledger_key_contract_data, ""}} = LedgerKeyContractData.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyContractData.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      ledger_key_contract_data: ledger_key_contract_data,
      binary: binary
    } do
      {^ledger_key_contract_data, ""} = LedgerKeyContractData.decode_xdr!(binary)
    end
  end
end
