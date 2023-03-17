defmodule StellarBase.XDR.SCSpecTypeMapTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeMap, Void}

  describe "SCSpecTypeMap" do
    setup do
      keyType = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
      valueType = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        keyType: keyType,
        valueType: valueType,
        sc_spec_type_map: SCSpecTypeMap.new(keyType, valueType),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/2", %{keyType: keyType, valueType: valueType} do
      %SCSpecTypeMap{keyType: ^keyType, valueType: ^valueType} =
        SCSpecTypeMap.new(keyType, valueType)
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
