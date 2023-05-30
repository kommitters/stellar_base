defmodule StellarBase.XDR.UploadContractWasmArgsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{UploadContractWasmArgs, VariableOpaque256000}

  describe "UploadContractWasmArgs" do
    setup do
      code = VariableOpaque256000.new("GCIZ3GSM5")

      %{
        code: code,
        upload_contract_wasm_args: UploadContractWasmArgs.new(code),
        binary: <<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code} do
      %UploadContractWasmArgs{code: ^code} = UploadContractWasmArgs.new(code)
    end

    test "encode_xdr/1", %{upload_contract_wasm_args: upload_contract_wasm_args, binary: binary} do
      {:ok, ^binary} = UploadContractWasmArgs.encode_xdr(upload_contract_wasm_args)
    end

    test "encode_xdr!/1", %{
      upload_contract_wasm_args: upload_contract_wasm_args,
      binary: binary
    } do
      ^binary = UploadContractWasmArgs.encode_xdr!(upload_contract_wasm_args)
    end

    test "decode_xdr/2", %{upload_contract_wasm_args: upload_contract_wasm_args, binary: binary} do
      {:ok, {^upload_contract_wasm_args, ""}} = UploadContractWasmArgs.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = UploadContractWasmArgs.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      upload_contract_wasm_args: upload_contract_wasm_args,
      binary: binary
    } do
      {^upload_contract_wasm_args, ^binary} = UploadContractWasmArgs.decode_xdr!(binary <> binary)
    end
  end
end
