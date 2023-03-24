defmodule StellarBase.XDR.InstallContractCodeArgsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{InstallContractCodeArgs, VariableOpaque256000}

  describe "InstallContractCodeArgs" do
    setup do
      code = VariableOpaque256000.new("GCIZ3GSM5")

      %{
        code: code,
        install_contract_code_args: InstallContractCodeArgs.new(code),
        binary: <<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code} do
      %InstallContractCodeArgs{code: ^code} = InstallContractCodeArgs.new(code)
    end

    test "encode_xdr/1", %{install_contract_code_args: install_contract_code_args, binary: binary} do
      {:ok, ^binary} = InstallContractCodeArgs.encode_xdr(install_contract_code_args)
    end

    test "encode_xdr!/1", %{
      install_contract_code_args: install_contract_code_args,
      binary: binary
    } do
      ^binary = InstallContractCodeArgs.encode_xdr!(install_contract_code_args)
    end

    test "decode_xdr/2", %{install_contract_code_args: install_contract_code_args, binary: binary} do
      {:ok, {^install_contract_code_args, ""}} = InstallContractCodeArgs.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InstallContractCodeArgs.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      install_contract_code_args: install_contract_code_args,
      binary: binary
    } do
      {^install_contract_code_args, ^binary} =
        InstallContractCodeArgs.decode_xdr!(binary <> binary)
    end
  end
end
