defmodule StellarBase.XDR.SCSpecTypeMapTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeMap, Void}

  describe "SCSpecTypeMap" do
    setup do
      key_type = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
      value_type = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        key_type: key_type,
        value_type: value_type,
        sc_spec_type_map: SCSpecTypeMap.new(key_type, value_type),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/2", %{key_type: key_type, value_type: value_type} do
      %SCSpecTypeMap{key_type: ^key_type, value_type: ^value_type} =
        SCSpecTypeMap.new(key_type, value_type)
    end

    test "encode_xdr/1", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecTypeMap.encode_xdr(sc_spec_type_map)
    end

    test "encode_xdr!/1", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      ^binary = SCSpecTypeMap.encode_xdr!(sc_spec_type_map)
    end

    test "decode_xdr/2", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      {:ok, {^sc_spec_type_map, ""}} = SCSpecTypeMap.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeMap.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      {^sc_spec_type_map, ^binary} = SCSpecTypeMap.decode_xdr!(binary <> binary)
    end
  end
end
