defmodule StellarBase.XDR.SCSpecTypeResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeResult, Void}

  describe "SCSpecTypeResult" do
    setup do
      ok_type = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
      error_type = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        ok_type: ok_type,
        error_type: error_type,
        sc_spec_type_map: SCSpecTypeResult.new(ok_type, error_type),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/2", %{ok_type: ok_type, error_type: error_type} do
      %SCSpecTypeResult{ok_type: ^ok_type, error_type: ^error_type} =
        SCSpecTypeResult.new(ok_type, error_type)
    end

    test "encode_xdr/1", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecTypeResult.encode_xdr(sc_spec_type_map)
    end

    test "encode_xdr!/1", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      ^binary = SCSpecTypeResult.encode_xdr!(sc_spec_type_map)
    end

    test "decode_xdr/2", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      {:ok, {^sc_spec_type_map, ""}} = SCSpecTypeResult.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecTypeResult.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_type_map: sc_spec_type_map,
      binary: binary
    } do
      {^sc_spec_type_map, ^binary} = SCSpecTypeResult.decode_xdr!(binary <> binary)
    end
  end
end
