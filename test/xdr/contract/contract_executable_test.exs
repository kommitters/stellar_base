defmodule StellarBase.XDR.ContractExecutableTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractExecutable,
    ContractExecutableType,
    Hash,
    Void
  }

  setup do
    binary_wasm =
      <<86, 32, 6, 9, 172, 4, 212, 185, 249, 87, 184, 164, 58, 34, 167, 183, 226, 117, 205, 116,
        11, 130, 119, 172, 224, 51, 12, 148, 90, 251, 17, 12>>

    binary_wasm_result =
      <<0, 0, 0, 0, 86, 32, 6, 9, 172, 4, 212, 185, 249, 87, 184, 164, 58, 34, 167, 183, 226, 117,
        205, 116, 11, 130, 119, 172, 224, 51, 12, 148, 90, 251, 17, 12>>

    binary_token = <<0, 0, 0, 1>>
    wasm_value = Hash.new(binary_wasm)
    token_value = Void.new()
    wasm_type = %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_WASM}
    token_type = %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_STELLAR_ASSET}
    contract_executable_wasm = ContractExecutable.new(wasm_value, wasm_type)
    contract_executable_token = ContractExecutable.new(token_value, token_type)

    %{
      binary_wasm: binary_wasm,
      binary_token: binary_token,
      wasm_value: wasm_value,
      token_value: token_value,
      wasm_type: wasm_type,
      token_type: token_type,
      binary_wasm_result: binary_wasm_result,
      contract_executable_token: contract_executable_token,
      contract_executable_wasm: contract_executable_wasm
    }
  end

  test "new/1 with wasm value", %{wasm_value: wasm_value, wasm_type: wasm_type} do
    %ContractExecutable{value: ^wasm_value, type: ^wasm_type} =
      ContractExecutable.new(wasm_value, wasm_type)
  end

  test "new/1 with token value", %{token_value: token_value, token_type: token_type} do
    %ContractExecutable{value: ^token_value, type: ^token_type} =
      ContractExecutable.new(token_value, token_type)
  end

  test "encode_xdr/1 with token value", %{
    binary_token: binary_token,
    token_value: token_value,
    token_type: token_type
  } do
    {:ok, ^binary_token} =
      token_value
      |> ContractExecutable.new(token_type)
      |> ContractExecutable.encode_xdr()
  end

  test "encode_xdr!/1 with token value", %{
    binary_token: binary_token,
    token_value: token_value,
    token_type: token_type
  } do
    ^binary_token =
      token_value
      |> ContractExecutable.new(token_type)
      |> ContractExecutable.encode_xdr!()
  end

  test "encode_xdr/1 with wasm value", %{
    wasm_value: wasm_value,
    wasm_type: wasm_type,
    binary_wasm_result: binary_wasm_result
  } do
    {:ok, ^binary_wasm_result} =
      wasm_value
      |> ContractExecutable.new(wasm_type)
      |> ContractExecutable.encode_xdr()
  end

  test "decode_xdr/2 with wasm value", %{
    binary_wasm_result: binary_wasm_result,
    contract_executable_wasm: contract_executable_wasm
  } do
    {:ok, {^contract_executable_wasm, ""}} = ContractExecutable.decode_xdr(binary_wasm_result)
  end

  test "decode_xdr/2 with token value", %{
    binary_token: binary_token,
    contract_executable_token: contract_executable_token
  } do
    {:ok, {^contract_executable_token, ""}} = ContractExecutable.decode_xdr(binary_token)
  end

  test "decode_xdr!/2 with wasm value", %{
    binary_wasm_result: binary_wasm_result,
    contract_executable_wasm: contract_executable_wasm
  } do
    {^contract_executable_wasm, ^binary_wasm_result} =
      ContractExecutable.decode_xdr!(binary_wasm_result <> binary_wasm_result)
  end

  test "decode_xdr!/2 with token value", %{
    binary_token: binary_token,
    contract_executable_token: contract_executable_token
  } do
    {^contract_executable_token, ^binary_token} =
      ContractExecutable.decode_xdr!(binary_token <> binary_token)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ContractExecutable.decode_xdr(123)
  end
end
