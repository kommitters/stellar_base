defmodule StellarBase.XDR.SCSpecUDTStructV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    String1024,
    String60,
    String30,
    String80,
    SCSpecUDTStructFieldV040,
    SCSpecUDTStructFieldV0,
    SCSpecUDTStructV0,
    SCSpecType,
    SCSpecTypeDef,
    Void
  }

  describe "SCSpecUDTStructV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      lib = String80.new("Hello there 80")
      name = String60.new("Hello there 60")

      name_udt_struct_field = String30.new("Hello there 30")
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type = SCSpecTypeDef.new(code, type_val)

      field = SCSpecUDTStructFieldV0.new(doc, name_udt_struct_field, type)
      udt_struct_fields = [field, field]

      fields = SCSpecUDTStructFieldV040.new(udt_struct_fields)

      %{
        doc: doc,
        lib: lib,
        name: name,
        fields: fields,
        sc_spec_udt_union_v0: SCSpecUDTStructV0.new(doc, lib, name, fields),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 32, 56, 48, 0, 0, 0, 0, 0, 14, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 32, 54, 48, 0, 0, 0, 0, 0, 2, 0, 0, 0, 26, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32, 105, 115,
            32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108, 108, 111, 32, 116,
            104, 101, 114, 101, 32, 51, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 72, 101, 108, 108, 111,
            32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116,
            101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101,
            32, 51, 48, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{doc: doc, lib: lib, name: name, fields: fields} do
      %SCSpecUDTStructV0{doc: ^doc, lib: ^lib, name: ^name, fields: ^fields} =
        SCSpecUDTStructV0.new(doc, lib, name, fields)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTStructV0.encode_xdr(sc_spec_udt_union_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      ^binary = SCSpecUDTStructV0.encode_xdr!(sc_spec_udt_union_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_union_v0, ""}} = SCSpecUDTStructV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTStructV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      {^sc_spec_udt_union_v0, ^binary} = SCSpecUDTStructV0.decode_xdr!(binary <> binary)
    end
  end
end
