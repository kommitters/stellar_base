defmodule StellarBase.XDR.SCSpecTypeResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecType, SCSpecTypeDef, SCSpecTypeResult, Void}

  describe "SCSpecTypeResult" do
    setup do
      okType = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))
      errorType = SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL))

      %{
        okType: okType,
        errorType: errorType,
        sc_spec_type_map: SCSpecTypeResult.new(okType, errorType),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/2", %{okType: okType, errorType: errorType} do
      %SCSpecTypeResult{okType: ^okType, errorType: ^errorType} =
        SCSpecTypeResult.new(okType, errorType)
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
