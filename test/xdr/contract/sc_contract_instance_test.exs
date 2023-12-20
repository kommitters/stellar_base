defmodule StellarBase.XDR.SCContractInstanceTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractExecutable,
    ContractExecutableType,
    SCContractInstance,
    OptionalSCMap,
    Hash,
    Void
  }

  setup do
    binary_wasm =
      <<86, 32, 6, 9, 172, 4, 212, 185, 249, 87, 184, 164, 58, 34, 167, 183, 226, 117, 205, 116,
        11, 130, 119, 172, 224, 51, 12, 148, 90, 251, 17, 12>>

    binary_wasm_result =
      <<0, 0, 0, 0, 86, 32, 6, 9, 172, 4, 212, 185, 249, 87, 184, 164, 58, 34, 167, 183, 226, 117,
        205, 116, 11, 130, 119, 172, 224, 51, 12, 148, 90, 251, 17, 12, 0, 0, 0, 0>>

    binary_token = <<0, 0, 0, 1, 0, 0, 0, 0>>
    wasm_value = Hash.new(binary_wasm)
    token_value = Void.new()
    wasm_type = %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_WASM}
    token_type = %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_STELLAR_ASSET}
    contract_executable_wasm = ContractExecutable.new(wasm_value, wasm_type)
    contract_executable_token = ContractExecutable.new(token_value, token_type)

    optional_map = OptionalSCMap.new()
    SCContractInstance.new(contract_executable_wasm, optional_map)

    sc_contract_instance_with_wasm =
      SCContractInstance.new(contract_executable_wasm, optional_map)

    sc_contract_instance_with_token =
      SCContractInstance.new(contract_executable_token, optional_map)

    %{
      binary_wasm: binary_wasm,
      binary_token: binary_token,
      binary_wasm_result: binary_wasm_result,
      wasm_value: wasm_value,
      token_value: token_value,
      wasm_type: wasm_type,
      token_type: token_type,
      contract_executable_wasm: contract_executable_wasm,
      contract_executable_token: contract_executable_token,
      optional_map: optional_map,
      sc_contract_instance_with_token: sc_contract_instance_with_token,
      sc_contract_instance_with_wasm: sc_contract_instance_with_wasm
    }
  end

  test "new/2 with wasm value", %{
    contract_executable_wasm: contract_executable_wasm,
    optional_map: optional_map
  } do
    %SCContractInstance{executable: ^contract_executable_wasm, storage: ^optional_map} =
      SCContractInstance.new(contract_executable_wasm, optional_map)
  end

  test "new/2 with token value", %{
    contract_executable_token: contract_executable_token,
    optional_map: optional_map
  } do
    %SCContractInstance{executable: ^contract_executable_token, storage: ^optional_map} =
      SCContractInstance.new(contract_executable_token, optional_map)
  end

  test "encode_xdr/1 with wasm value", %{
    binary_wasm_result: binary_wasm_result,
    contract_executable_wasm: contract_executable_wasm,
    optional_map: optional_map
  } do
    {:ok, ^binary_wasm_result} =
      contract_executable_wasm
      |> SCContractInstance.new(optional_map)
      |> SCContractInstance.encode_xdr()
  end

  test "encode_xdr/1 with token value", %{
    binary_token: binary_token,
    contract_executable_token: contract_executable_token,
    optional_map: optional_map
  } do
    {:ok, ^binary_token} =
      SCContractInstance.new(contract_executable_token, optional_map)
      |> SCContractInstance.encode_xdr()
  end

  test "encode_xdr!/1 with wasm value", %{
    binary_wasm_result: binary_wasm_result,
    contract_executable_wasm: contract_executable_wasm,
    optional_map: optional_map
  } do
    ^binary_wasm_result =
      contract_executable_wasm
      |> SCContractInstance.new(optional_map)
      |> SCContractInstance.encode_xdr!()
  end

  test "encode_xdr!/1 with token value", %{
    binary_token: binary_token,
    contract_executable_token: contract_executable_token,
    optional_map: optional_map
  } do
    ^binary_token =
      SCContractInstance.new(contract_executable_token, optional_map)
      |> SCContractInstance.encode_xdr!()
  end

  test "decode_xdr/2 with wasm value", %{
    binary_wasm_result: binary_wasm_result,
    sc_contract_instance_with_wasm: sc_contract_instance_with_wasm
  } do
    {:ok, {^sc_contract_instance_with_wasm, ""}} =
      SCContractInstance.decode_xdr(binary_wasm_result)
  end

  test "decode_xdr/2 with token value", %{
    binary_token: binary_token,
    sc_contract_instance_with_token: sc_contract_instance_with_token
  } do
    {:ok, {^sc_contract_instance_with_token, ""}} = SCContractInstance.decode_xdr(binary_token)
  end

  test "decode_xdr!/2 with wasm value", %{
    binary_wasm_result: binary_wasm_result,
    sc_contract_instance_with_wasm: sc_contract_instance_with_wasm
  } do
    {^sc_contract_instance_with_wasm, ""} = SCContractInstance.decode_xdr!(binary_wasm_result)
  end

  test "decode_xdr!/2 with token value", %{
    binary_token: binary_token,
    sc_contract_instance_with_token: sc_contract_instance_with_token
  } do
    {^sc_contract_instance_with_token, ""} = SCContractInstance.decode_xdr!(binary_token)
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = SCContractInstance.decode_xdr(123)
  end
end
