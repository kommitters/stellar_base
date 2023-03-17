defmodule StellarBase.XDR.SCSpecTypeSetTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeSet, Void}

  describe "SCSpecTypeSet" do
    setup do
      element_type = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        element_type: element_type,
        sc_spec_type_map: SCSpecTypeSet.new(element_type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{element_type: element_type} do
      %SCSpecTypeSet{element_type: ^element_type} = SCSpecTypeSet.new(element_type)
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
