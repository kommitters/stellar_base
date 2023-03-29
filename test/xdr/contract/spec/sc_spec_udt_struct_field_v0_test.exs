defmodule StellarBase.XDR.SCSpecUDTStructFieldV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    String1024,
    String30,
    SCSpecTypeDef,
    SCSpecType,
    SCSpecUDTStructFieldV0,
    Void
  }

  describe "SCSpecUDTStructFieldV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String30.new("Hello there 30")
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type = SCSpecTypeDef.new(code, type_val)

      %{
        doc: doc,
        name: name,
        type: type,
        sc_spec_udt_struct_field_v0: SCSpecUDTStructFieldV0.new(doc, name, type),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 32, 51, 48, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{doc: doc, name: name, type: type} do
      %SCSpecUDTStructFieldV0{doc: ^doc, name: ^name, type: ^type} =
        SCSpecUDTStructFieldV0.new(doc, name, type)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_struct_field_v0: sc_spec_udt_struct_field_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTStructFieldV0.encode_xdr(sc_spec_udt_struct_field_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_struct_field_v0: sc_spec_udt_struct_field_v0,
      binary: binary
    } do
      ^binary = SCSpecUDTStructFieldV0.encode_xdr!(sc_spec_udt_struct_field_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_udt_struct_field_v0: sc_spec_udt_struct_field_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_struct_field_v0, ""}} = SCSpecUDTStructFieldV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTStructFieldV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_udt_struct_field_v0: sc_spec_udt_struct_field_v0,
      binary: binary
    } do
      {^sc_spec_udt_struct_field_v0, ^binary} =
        SCSpecUDTStructFieldV0.decode_xdr!(binary <> binary)
    end
  end
end
