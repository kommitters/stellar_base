defmodule StellarBase.XDR.SCSpecTypeTupleTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeTuple, SCSpecTypeDefList12, Void}

  describe "SCSpecTypeTuple" do
    setup do
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type_u128 = SCSpecType.new(:SC_SPEC_TYPE_U128)
      sc_spec_type_def_1 = SCSpecTypeDef.new(code, type_val)
      sc_spec_type_def_2 = SCSpecTypeDef.new(code, type_u128)

      value_types = SCSpecTypeDefList12.new([sc_spec_type_def_1, sc_spec_type_def_2])

      %{
        value_types: value_types,
        sc_spec_type_map: SCSpecTypeTuple.new(value_types),
        binary: <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 5>>
      }
    end

    test "new/1", %{value_types: value_types} do
      %SCSpecTypeTuple{value_types: ^value_types} = SCSpecTypeTuple.new(value_types)
    end

    test "encode_xdr/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, ^binary} = SCSpecTypeTuple.encode_xdr(sc_spec_type_map)
    end

    test "encode_xdr!/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      ^binary = SCSpecTypeTuple.encode_xdr!(sc_spec_type_map)
    end

    test "decode_xdr/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, {^sc_spec_type_map, ""}} = SCSpecTypeTuple.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeTuple.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {^sc_spec_type_map, ^binary} = SCSpecTypeTuple.decode_xdr!(binary <> binary)
    end
  end
end
