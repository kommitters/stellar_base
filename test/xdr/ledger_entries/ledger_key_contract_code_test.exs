defmodule StellarBase.XDR.LedgerKeyContractCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractEntryBodyType,
    Hash,
    LedgerKeyContractCode
  }

  describe "LedgerKeyContractCode" do
    setup do
      hash = Hash.new("CBT6AP4HS575FETHYO6CMIZ2NUFPLKC7")
      body_type = ContractEntryBodyType.new(:DATA_ENTRY)

      %{
        hash: hash,
        body_type: body_type,
        ledger_key_contract_code: LedgerKeyContractCode.new(hash, body_type),
        binary:
          <<67, 66, 84, 54, 65, 80, 52, 72, 83, 53, 55, 53, 70, 69, 84, 72, 89, 79, 54, 67, 77,
            73, 90, 50, 78, 85, 70, 80, 76, 75, 67, 55, 0, 0, 0, 0>>
      }
    end

    test "new/3", %{
      hash: hash,
      body_type: body_type
    } do
      %LedgerKeyContractCode{
        hash: ^hash,
        body_type: ^body_type
      } = LedgerKeyContractCode.new(hash, body_type)
    end

    test "encode_xdr/1", %{
      ledger_key_contract_code: ledger_key_contract_code,
      binary: binary
    } do
      {:ok, ^binary} = LedgerKeyContractCode.encode_xdr(ledger_key_contract_code)
    end

    test "encode_xdr!/1", %{
      ledger_key_contract_code: ledger_key_contract_code,
      binary: binary
    } do
      ^binary = LedgerKeyContractCode.encode_xdr!(ledger_key_contract_code)
    end

    test "decode_xdr/2", %{
      ledger_key_contract_code: ledger_key_contract_code,
      binary: binary
    } do
      {:ok, {^ledger_key_contract_code, ""}} = LedgerKeyContractCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyContractCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      ledger_key_contract_code: ledger_key_contract_code,
      binary: binary
    } do
      {^ledger_key_contract_code, ""} = LedgerKeyContractCode.decode_xdr!(binary)
    end
  end
end
