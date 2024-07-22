defmodule StellarBase.XDR.ContractCodeEntryExtTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractCodeCostInputs,
    ContractCodeEntryExt,
    ContractCodeEntryV1,
    ExtensionPoint,
    UInt32,
    Void
  }

  describe "ContractCodeEntryExt with Void" do
    setup do
      value = Void.new()
      type = 0
      contract_code_entry_ext = ContractCodeEntryExt.new(value, type)

      %{
        value: value,
        type: type,
        contract_code_entry_ext: contract_code_entry_ext,
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/2", %{
      value: value,
      type: type
    } do
      %ContractCodeEntryExt{
        value: ^value,
        type: ^type
      } = ContractCodeEntryExt.new(value, type)
    end

    test "encode_xdr/1", %{contract_code_entry_ext: contract_code_entry_ext, binary: binary} do
      {:ok, ^binary} = ContractCodeEntryExt.encode_xdr(contract_code_entry_ext)
    end

    test "encode_xdr!/1", %{
      contract_code_entry_ext: contract_code_entry_ext,
      binary: binary
    } do
      ^binary = ContractCodeEntryExt.encode_xdr!(contract_code_entry_ext)
    end

    test "decode_xdr/2", %{contract_code_entry_ext: contract_code_entry_ext, binary: binary} do
      {:ok, {^contract_code_entry_ext, ""}} = ContractCodeEntryExt.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractCodeEntryExt.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      contract_code_entry_ext: contract_code_entry_ext,
      binary: binary
    } do
      {^contract_code_entry_ext, ""} = ContractCodeEntryExt.decode_xdr!(binary)
    end
  end

  describe "ContractCodeEntryExt with ContractCodeEntryV1" do
    setup do
      general_number = UInt32.new(1)
      ext = ExtensionPoint.new(Void.new(), 0)

      constract_code_cost_inputs =
        ContractCodeCostInputs.new(
          ext,
          general_number,
          general_number,
          general_number,
          general_number,
          general_number,
          general_number,
          general_number,
          general_number,
          general_number,
          general_number
        )

      value = ContractCodeEntryV1.new(ext, constract_code_cost_inputs)
      type = 1
      contract_code_entry_ext = ContractCodeEntryExt.new(value, type)

      %{
        value: value,
        type: type,
        contract_code_entry_ext: contract_code_entry_ext,
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,
            0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1>>
      }
    end

    test "new/2", %{
      value: value,
      type: type
    } do
      %ContractCodeEntryExt{
        value: ^value,
        type: ^type
      } = ContractCodeEntryExt.new(value, type)
    end

    test "encode_xdr/1", %{contract_code_entry_ext: contract_code_entry_ext, binary: binary} do
      {:ok, ^binary} = ContractCodeEntryExt.encode_xdr(contract_code_entry_ext)
    end

    test "encode_xdr!/1", %{
      contract_code_entry_ext: contract_code_entry_ext,
      binary: binary
    } do
      ^binary = ContractCodeEntryExt.encode_xdr!(contract_code_entry_ext)
    end

    test "decode_xdr/2", %{contract_code_entry_ext: contract_code_entry_ext, binary: binary} do
      {:ok, {^contract_code_entry_ext, ""}} = ContractCodeEntryExt.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractCodeEntryExt.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      contract_code_entry_ext: contract_code_entry_ext,
      binary: binary
    } do
      {^contract_code_entry_ext, ""} = ContractCodeEntryExt.decode_xdr!(binary)
    end
  end
end
