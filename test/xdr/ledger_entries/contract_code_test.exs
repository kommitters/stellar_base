defmodule StellarBase.XDR.ContractCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ContractCode, Hash}

  describe "ContractCode" do
    setup do
      hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        hash: hash,
        contract_code_entry: ContractCode.new(hash),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1", %{hash: hash} do
      %ContractCode{hash: ^hash} = ContractCode.new(hash)
    end

    test "encode_xdr/1", %{contract_code_entry: contract_code_entry, binary: binary} do
      {:ok, ^binary} = ContractCode.encode_xdr(contract_code_entry)
    end

    test "encode_xdr!/1", %{
      contract_code_entry: contract_code_entry,
      binary: binary
    } do
      ^binary = ContractCode.encode_xdr!(contract_code_entry)
    end

    test "decode_xdr/2", %{contract_code_entry: contract_code_entry, binary: binary} do
      {:ok, {^contract_code_entry, ""}} = ContractCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractCode.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      contract_code_entry: contract_code_entry,
      binary: binary
    } do
      {^contract_code_entry, ^binary} = ContractCode.decode_xdr!(binary <> binary)
    end
  end
end
