defmodule StellarBase.XDR.SCSpecTypeOptionTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeOption, Void}

  describe "SCSpecTypeOption" do
    setup do
      value_type = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        value_type: value_type,
        sc_spec_type_map: SCSpecTypeOption.new(value_type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{value_type: value_type} do
      %SCSpecTypeOption{value_type: ^value_type} = SCSpecTypeOption.new(value_type)
    end

    test "encode_xdr/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, ^binary} = SCSpecTypeOption.encode_xdr(sc_spec_type_map)
    end

    test "encode_xdr!/1", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      ^binary = SCSpecTypeOption.encode_xdr!(sc_spec_type_map)
    end

    test "decode_xdr/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {:ok, {^sc_spec_type_map, ""}} = SCSpecTypeOption.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeOption.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_type_map: sc_spec_type_map, binary: binary} do
      {^sc_spec_type_map, ^binary} = SCSpecTypeOption.decode_xdr!(binary <> binary)
    end
  end
end
