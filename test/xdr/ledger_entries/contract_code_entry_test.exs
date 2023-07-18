defmodule StellarBase.XDR.ContractCodeEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractCodeEntry,
    ContractCodeEntryBody,
    ContractEntryBodyType,
    ExtensionPoint,
    Hash,
    UInt32,
    VariableOpaque,
    Void
  }

  describe "ContractCodeEntry" do
    setup do
      ext = ExtensionPoint.new(Void.new(), 0)
      hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      code = VariableOpaque.new("GCIZ3GSM5")
      type = ContractEntryBodyType.new()
      body = ContractCodeEntryBody.new(code, type)
      expiration_ledger_seq = UInt32.new(123)

      %{
        ext: ext,
        hash: hash,
        body: body,
        expiration_ledger_seq: expiration_ledger_seq,
        contract_code_entry: ContractCodeEntry.new(ext, hash, body, expiration_ledger_seq),
        binary:
          <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
            54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 0, 0, 0, 9, 71,
            67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0, 0, 0, 0, 123>>
      }
    end

    test "new/1", %{
      ext: ext,
      hash: hash,
      body: body,
      expiration_ledger_seq: expiration_ledger_seq
    } do
      %ContractCodeEntry{
        hash: ^hash,
        body: ^body,
        ext: ^ext,
        expiration_ledger_seq: ^expiration_ledger_seq
      } = ContractCodeEntry.new(ext, hash, body, expiration_ledger_seq)
    end

    test "encode_xdr/1", %{contract_code_entry: contract_code_entry, binary: binary} do
      {:ok, ^binary} = ContractCodeEntry.encode_xdr(contract_code_entry)
    end

    test "encode_xdr!/1", %{
      contract_code_entry: contract_code_entry,
      binary: binary
    } do
      ^binary = ContractCodeEntry.encode_xdr!(contract_code_entry)
    end

    test "decode_xdr/2", %{contract_code_entry: contract_code_entry, binary: binary} do
      {:ok, {^contract_code_entry, ""}} = ContractCodeEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractCodeEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      contract_code_entry: contract_code_entry,
      binary: binary
    } do
      {^contract_code_entry, ^binary} = ContractCodeEntry.decode_xdr!(binary <> binary)
    end
  end
end
