defmodule StellarBase.XDR.ContractCodeEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractCodeEntry,
    ExtensionPoint,
    Hash,
    VariableOpaque,
    Void
  }

  describe "ContractCodeEntry" do
    setup do
      ext = ExtensionPoint.new(Void.new(), 0)
      hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      code = VariableOpaque.new("GCIZ3GSM5")

      %{
        ext: ext,
        hash: hash,
        code: code,
        contract_code_entry: ContractCodeEntry.new(hash, code, ext),
        binary:
          <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84,
            72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83,
            77, 53, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      ext: ext,
      hash: hash,
      code: code
    } do
      %ContractCodeEntry{
        hash: ^hash,
        code: ^code,
        ext: ^ext
      } = ContractCodeEntry.new(hash, code, ext)
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
