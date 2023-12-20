defmodule StellarBase.XDR.ContractExecutableTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractExecutableType

  setup do
    %{
      wasm: :CONTRACT_EXECUTABLE_WASM,
      token: :CONTRACT_EXECUTABLE_STELLAR_ASSET,
      binary_wasm: <<0, 0, 0, 0>>,
      binary_token: <<0, 0, 0, 1>>,
      wasm_identifier: :CONTRACT_EXECUTABLE_WASM,
      token_identifier: :CONTRACT_EXECUTABLE_STELLAR_ASSET,
      wasm_type: %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_WASM},
      token_type: %ContractExecutableType{identifier: :CONTRACT_EXECUTABLE_STELLAR_ASSET}
    }
  end

  test "new/1 with wasm identifier", %{wasm_identifier: wasm_identifier} do
    %ContractExecutableType{identifier: ^wasm_identifier} =
      ContractExecutableType.new(:CONTRACT_EXECUTABLE_WASM)
  end

  test "new/1 with token identifier", %{token_identifier: token_identifier} do
    %ContractExecutableType{identifier: ^token_identifier} =
      ContractExecutableType.new(:CONTRACT_EXECUTABLE_STELLAR_ASSET)
  end

  test "encode_xdr/1 with wasm identifier", %{binary_wasm: binary_wasm, wasm_type: wasm_type} do
    {:ok, ^binary_wasm} = ContractExecutableType.encode_xdr(wasm_type)
  end

  test "encode_xdr/1 with token identifier", %{binary_token: binary_token, token_type: token_type} do
    {:ok, ^binary_token} = ContractExecutableType.encode_xdr(token_type)
  end

  test "encode_xdr!/1 with wasm identifier", %{binary_wasm: binary_wasm, wasm_type: wasm_type} do
    ^binary_wasm = ContractExecutableType.encode_xdr!(wasm_type)
  end

  test "encode_xdr!/1 with token identifier", %{
    binary_token: binary_token,
    token_type: token_type
  } do
    ^binary_token = ContractExecutableType.encode_xdr!(token_type)
  end

  test "decode_xdr/2 with wasm identifier", %{binary_wasm: binary_wasm, wasm_type: wasm_type} do
    {:ok, {^wasm_type, ""}} = ContractExecutableType.decode_xdr(binary_wasm)
  end

  test "decode_xdr/2 with token identifier", %{binary_token: binary_token, token_type: token_type} do
    {:ok, {^token_type, ""}} = ContractExecutableType.decode_xdr(binary_token)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ContractExecutableType.decode_xdr(123)
  end

  test "decode_xdr!/2 with wasm identifier", %{binary_wasm: binary_wasm, wasm_type: wasm_type} do
    {^wasm_type, ^binary_wasm} = ContractExecutableType.decode_xdr!(binary_wasm <> binary_wasm)
  end

  test "decode_xdr!/2 with token identifier", %{
    binary_token: binary_token,
    token_type: token_type
  } do
    {^token_type, ^binary_token} =
      ContractExecutableType.decode_xdr!(binary_token <> binary_token)
  end
end
