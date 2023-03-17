defmodule StellarBase.XDR.SCSpecTypeTupleTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeTuple, SCSpecTypeDef12, Void}

  describe "SCSpecTypeTuple" do
    setup do
      valueTypes =
        SCSpecTypeDef12.new([
          SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL)),
          SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_U128))
        ])

      %{
        valueTypes: valueTypes,
        sc_spec_type_map: SCSpecTypeTuple.new(valueTypes),
        binary: <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 5>>
      }
    end

    test "new/1", %{valueTypes: valueTypes} do
      %SCSpecTypeTuple{valueTypes: ^valueTypes} = SCSpecTypeTuple.new(valueTypes)
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
