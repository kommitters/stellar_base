defmodule StellarBase.XDR.ContractCodeEntryV1Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ContractCodeCostInputs,
    ContractCodeEntryV1,
    ExtensionPoint,
    UInt32,
    Void
  }

  describe "ContractCodeEntryV1" do
    setup do
      general_number = UInt32.new(1)
      ext = ExtensionPoint.new(Void.new(), 0)

      cost_inputs =
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

      contra_code_entry_v1 = ContractCodeEntryV1.new(ext, cost_inputs)

      %{
        ext: ext,
        cost_inputs: cost_inputs,
        contra_code_entry_v1: contra_code_entry_v1,
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,
            0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1>>
      }
    end

    test "new/2", %{
      ext: ext,
      cost_inputs: cost_inputs
    } do
      %ContractCodeEntryV1{
        ext: ^ext,
        cost_inputs: ^cost_inputs
      } = ContractCodeEntryV1.new(ext, cost_inputs)
    end

    test "encode_xdr/1", %{contra_code_entry_v1: contra_code_entry_v1, binary: binary} do
      {:ok, ^binary} = ContractCodeEntryV1.encode_xdr(contra_code_entry_v1)
    end

    test "encode_xdr!/1", %{
      contra_code_entry_v1: contra_code_entry_v1,
      binary: binary
    } do
      ^binary = ContractCodeEntryV1.encode_xdr!(contra_code_entry_v1)
    end

    test "decode_xdr/2", %{contra_code_entry_v1: contra_code_entry_v1, binary: binary} do
      {:ok, {^contra_code_entry_v1, ""}} = ContractCodeEntryV1.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractCodeEntryV1.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      contra_code_entry_v1: contra_code_entry_v1,
      binary: binary
    } do
      {^contra_code_entry_v1, ""} = ContractCodeEntryV1.decode_xdr!(binary)
    end
  end
end
