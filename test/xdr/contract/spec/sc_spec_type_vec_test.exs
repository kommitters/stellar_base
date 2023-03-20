defmodule StellarBase.XDR.SCSpecTypeVecTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeVec, Void}

  describe "SCSpecTypeVec" do
    setup do
      code = Void.new()
      type = SCSpecType.new(:SC_SPEC_TYPE_VAL)

      element_type = SCSpecTypeDef.new(code, type)

      %{
        element_type: element_type,
        sc_spec_type_map: SCSpecTypeVec.new(element_type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{element_type: element_type} do
      %SCSpecTypeVec{element_type: ^element_type} = SCSpecTypeVec.new(element_type)
    end

    test "encode_xdr/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, ^binary} = SCSpecTypeVec.encode_xdr(sc_spec_type_map)
    end

    test "encode_xdr!/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      ^binary = SCSpecTypeVec.encode_xdr!(sc_spec_type_map)
    end

    test "decode_xdr/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, {^sc_spec_type_map, ""}} = SCSpecTypeVec.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeVec.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {^sc_spec_type_map, ^binary} = SCSpecTypeVec.decode_xdr!(binary <> binary)
    end
  end
end
