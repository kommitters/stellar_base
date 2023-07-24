defmodule StellarBase.XDR.ContractEntryBodyTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractEntryBodyType

  setup do
    type = :DATA_ENTRY
    contract_entry_body_type = ContractEntryBodyType.new(type)
    binary = <<0, 0, 0, 0>>

    %{
      type: type,
      contract_entry_body_type: contract_entry_body_type,
      binary: binary
    }
  end

  test "new/1", %{type: type} do
    %ContractEntryBodyType{identifier: ^type} = ContractEntryBodyType.new(type)
  end

  test "encode_xdr/1", %{type: type, binary: binary} do
    {:ok, ^binary} = type |> ContractEntryBodyType.new() |> ContractEntryBodyType.encode_xdr()
  end

  test "encode_xdr!/1", %{type: type, binary: binary} do
    ^binary = type |> ContractEntryBodyType.new() |> ContractEntryBodyType.encode_xdr!()
  end

  test "decode_xdr/2", %{contract_entry_body_type: contract_entry_body_type, binary: binary} do
    {:ok, {^contract_entry_body_type, ""}} = ContractEntryBodyType.decode_xdr(binary)
  end

  test "decode_xdr!/2", %{contract_entry_body_type: contract_entry_body_type, binary: binary} do
    {^contract_entry_body_type, ""} = ContractEntryBodyType.decode_xdr!(binary)
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = ContractEntryBodyType.decode_xdr(123)
  end
end
