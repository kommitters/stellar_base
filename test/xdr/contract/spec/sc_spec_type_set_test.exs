defmodule StellarBase.XDR.SCSpecTypeSetTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeSet, Void}

  describe "SCSpecTypeSet" do
    setup do
      elementType = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        elementType: elementType,
        sc_spec_type_map: SCSpecTypeSet.new(elementType),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{elementType: elementType} do
      %SCSpecTypeSet{elementType: ^elementType} = SCSpecTypeSet.new(elementType)
    end

    test "encode_xdr/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, ^binary} = SCSpecTypeSet.encode_xdr(sc_spec_type_map)
    end

    test "encode_xdr!/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      ^binary = SCSpecTypeSet.encode_xdr!(sc_spec_type_map)
    end

    test "decode_xdr/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, {^sc_spec_type_map, ""}} = SCSpecTypeSet.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeSet.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {^sc_spec_type_map, ^binary} = SCSpecTypeSet.decode_xdr!(binary <> binary)
    end
  end
end
