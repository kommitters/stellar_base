defmodule StellarBase.XDR.ContractCostParamsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ContractCostParams, ContractCostParamEntry, ExtensionPoint, Int64, Void}

  setup do
    const_term = Int64.new(10)
    linear_term = Int64.new(10)
    ext = ExtensionPoint.new(Void.new(), 0)

    contract_cost_param_entry1 =
      ContractCostParamEntry.new(
        ext,
        const_term,
        linear_term
      )

    contract_cost_param_entry2 =
      ContractCostParamEntry.new(
        ext,
        const_term,
        linear_term
      )

    param_entries = [contract_cost_param_entry1, contract_cost_param_entry2]
    contract_cost_params = ContractCostParams.new(param_entries)

    %{
      param_entries: param_entries,
      contract_cost_params: contract_cost_params,
      binary:
        <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    param_entries: param_entries
  } do
    %ContractCostParams{
      items: ^param_entries
    } = ContractCostParams.new(param_entries)
  end

  test "encode_xdr/1", %{
    contract_cost_params: contract_cost_params,
    binary: binary
  } do
    {:ok, ^binary} = ContractCostParams.encode_xdr(contract_cost_params)
  end

  test "encode_xdr!/1", %{
    contract_cost_params: contract_cost_params,
    binary: binary
  } do
    ^binary = ContractCostParams.encode_xdr!(contract_cost_params)
  end

  test "decode_xdr/2", %{
    contract_cost_params: contract_cost_params,
    binary: binary
  } do
    {:ok, {^contract_cost_params, ""}} = ContractCostParams.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ContractCostParams.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    contract_cost_params: contract_cost_params,
    binary: binary
  } do
    {^contract_cost_params, ^binary} = ContractCostParams.decode_xdr!(binary <> binary)
  end
end
