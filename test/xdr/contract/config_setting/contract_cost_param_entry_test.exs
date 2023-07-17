defmodule StellarBase.XDR.ContractCostParamEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ContractCostParamEntry, ExtensionPoint, Int64, Void}

  setup do
    const_term = Int64.new(10)
    linear_term = Int64.new(10)
    ext = ExtensionPoint.new(Void.new(), 0)

    contract_cost_param_entry =
      ContractCostParamEntry.new(
        ext,
        const_term,
        linear_term
      )

    %{
      const_term: const_term,
      linear_term: linear_term,
      ext: ext,
      contract_cost_param_entry: contract_cost_param_entry,
      binary: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    const_term: const_term,
    linear_term: linear_term,
    ext: ext
  } do
    %ContractCostParamEntry{
      ext: ^ext,
      const_term: ^const_term,
      linear_term: ^linear_term
    } =
      ContractCostParamEntry.new(
        ext,
        const_term,
        linear_term
      )
  end

  test "encode_xdr/1", %{
    contract_cost_param_entry: contract_cost_param_entry,
    binary: binary
  } do
    {:ok, ^binary} = ContractCostParamEntry.encode_xdr(contract_cost_param_entry)
  end

  test "encode_xdr!/1", %{
    contract_cost_param_entry: contract_cost_param_entry,
    binary: binary
  } do
    ^binary = ContractCostParamEntry.encode_xdr!(contract_cost_param_entry)
  end

  test "decode_xdr/2", %{
    contract_cost_param_entry: contract_cost_param_entry,
    binary: binary
  } do
    {:ok, {^contract_cost_param_entry, ""}} = ContractCostParamEntry.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ContractCostParamEntry.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    contract_cost_param_entry: contract_cost_param_entry,
    binary: binary
  } do
    {^contract_cost_param_entry, ^binary} = ContractCostParamEntry.decode_xdr!(binary <> binary)
  end
end
