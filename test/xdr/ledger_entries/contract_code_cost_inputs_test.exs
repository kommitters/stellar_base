defmodule StellarBase.XDR.ContractCodeCostInputsTest do
  use ExUnit.Case
  alias StellarBase.XDR.{ContractCodeCostInputs, ExtensionPoint, UInt32, Void}

  describe "ContractCodeCostInputs" do
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

      %{
        ext: ext,
        n_instructions_type: general_number,
        n_functions_type: general_number,
        n_globals_type: general_number,
        n_table_entries_type: general_number,
        n_types_type: general_number,
        n_data_segments_type: general_number,
        n_elem_segments_type: general_number,
        n_imports_type: general_number,
        n_exports_type: general_number,
        n_data_segment_bytes_type: general_number,
        cost_inputs: cost_inputs,
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,
            0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1>>
      }
    end

    test "new/11", %{
      ext: ext,
      n_instructions_type: n_instructions_type,
      n_functions_type: n_functions_type,
      n_globals_type: n_globals_type,
      n_table_entries_type: n_table_entries_type,
      n_types_type: n_types_type,
      n_data_segments_type: n_data_segments_type,
      n_elem_segments_type: n_elem_segments_type,
      n_imports_type: n_imports_type,
      n_exports_type: n_exports_type,
      n_data_segment_bytes_type: n_data_segment_bytes_type
    } do
      %ContractCodeCostInputs{
        ext: ^ext,
        n_instructions: ^n_instructions_type,
        n_functions: ^n_functions_type,
        n_globals: ^n_globals_type,
        n_table_entries: ^n_table_entries_type,
        n_types: ^n_types_type,
        n_data_segments: ^n_data_segments_type,
        n_elem_segments: ^n_elem_segments_type,
        n_imports: ^n_imports_type,
        n_exports: ^n_exports_type,
        n_data_segment_bytes: ^n_data_segment_bytes_type
      } =
        ContractCodeCostInputs.new(
          ext,
          n_instructions_type,
          n_functions_type,
          n_globals_type,
          n_table_entries_type,
          n_types_type,
          n_data_segments_type,
          n_elem_segments_type,
          n_imports_type,
          n_exports_type,
          n_data_segment_bytes_type
        )
    end

    test "encode_xdr/1", %{cost_inputs: cost_inputs, binary: binary} do
      {:ok, ^binary} =
        ContractCodeCostInputs.encode_xdr(cost_inputs)
    end

    test "encode_xdr!/1", %{cost_inputs: cost_inputs, binary: binary} do
      ^binary = ContractCodeCostInputs.encode_xdr!(cost_inputs)
    end

    test "decode_xdr/2", %{cost_inputs: cost_inputs, binary: binary} do
      {:ok, {^cost_inputs, ""}} =
        ContractCodeCostInputs.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ContractCodeCostInputs.decode_xdr(123)
    end

    test "decode_xdr!/2", %{cost_inputs: cost_inputs, binary: binary} do
      {^cost_inputs, ""} =
        ContractCodeCostInputs.decode_xdr!(binary)
    end
  end
end
