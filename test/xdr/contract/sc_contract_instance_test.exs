defmodule StellarBase.XDR.SCContractInstanceTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractExecutable,
    ContractExecutableType,
    SCContractInstance,
    OptionalSCMap,
    # MapEntry,
    Hash,
    Void
  }

  # setup do
  #   binary_wasm =
  #     <<86, 32, 6, 9, 172, 4, 212, 185, 249, 87, 184, 164, 58, 34, 167, 183, 226, 117, 205, 116,
  #       11, 130, 119, 172, 224, 51, 12, 148, 90, 251, 17, 12>>

  #   binary_wasm_result =
  #     <<0, 0, 0, 0, 86, 32, 6, 9, 172, 4, 212, 185, 249, 87, 184, 164, 58, 34, 167, 183, 226, 117,
  #       205, 116, 11, 130, 119, 172, 224, 51, 12, 148, 90, 251, 17, 12>>

  #   binary_token = <<0, 0, 0, 1>>
  #   wasm_value = Hash.new(binary_wasm)
  #   token_value = Void.new()
  #   wasm_type = %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_WASM}
  #   token_type = %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_TOKEN}
  #   contract_executable_wasm = ContractExecutable.new(wasm_value, wasm_type)
  #   contract_executable_token = ContractExecutable.new(token_value, token_type)

  #   binary_map_entry = <<0, 0, 0, 2, 0, 0, 0, 0>>

  #   # optional_map_entry = MapEntry.new(binary_map_entry)
  #   optional_map = OptionalSCMap.new()

  #   %{
  #     binary_wasm: binary_wasm,
  #     binary_token: binary_token,
  #     binary_wasm_result: binary_wasm_result,
  #     wasm_value: wasm_value,
  #     token_value: token_value,
  #     wasm_type: wasm_type,
  #     token_type: token_type,
  #     contract_executable_wasm: contract_executable_wasm,
  #     contract_executable_token: contract_executable_token,
  #     # optional_map_entry: optional_map_entry,
  #     optional_map: optional_map
  #   }
  # end

  # test "new/2 with wasm value", %{wasm_value: wasm_value, optional_map: optional_map} do
  #   %SCContractInstance{executable: ^wasm_value, storage: ^optional_map} =
  #     SCContractInstance.new(wasm_value, optional_map)
  # end

  # test "new/2 with token value", %{token_value: token_value, optional_map: optional_map} do
  #   %SCContractInstance{executable: ^token_value, storage: ^optional_map} =
  #     SCContractInstance.new(token_value, optional_map)
  # end

  # test "encode_xdr/1 with wasm value", %{
  #   binary_wasm_result: binary_wasm_result,
  #   wasm_value: wasm_value,
  #   optional_map: optional_map
  # } do
  #   {:ok, ^binary_wasm_result} =
  #     SCContractInstance.new(wasm_value, optional_map)
  #     |> SCContractInstance.encode_xdr()
  # end

  # test "decode_xdr/2 with wasm value", %{
  #   binary_wasm_result: binary_wasm_result,
  #   wasm_value: wasm_value,
  #   optional_map: optional_map
  # } do
  #   {:ok, {^SCContractInstance{executable: executable, storage: storage}, ""}} =
  #     SCContractInstance.decode_xdr(binary_wasm_result)

  #   assert executable == wasm_value
  #   assert storage == optional_map
  # end

  # test "encode_xdr/1 with token value", %{
  #   binary_token: binary_token,
  #   token_value: token_value,
  #   optional_map: optional_map
  # } do
  #   {:ok, ^binary_token} =
  #     SCContractInstance.new(token_value, optional_map)
  #     |> SCContractInstance.encode_xdr()
  # end

  # test "decode_xdr/2 with token value", %{
  #   binary_token: binary_token,
  #   token_value: token_value,
  #   optional_map: optional_map
  # } do
  #   {:ok, {^SCContractInstance{executable: executable, storage: storage}, ""}} =
  #     SCContractInstance.decode_xdr(binary_token)

  #   assert executable == token_value
  #   assert storage == optional_map
  # end

  # test "decode_xdr/2 with an invalid binary" do
  #   {:error, :not_binary} = SCContractInstance.decode_xdr(123)
  # end
end
