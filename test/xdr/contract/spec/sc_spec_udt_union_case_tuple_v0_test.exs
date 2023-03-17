defmodule StellarBase.XDR.SCSpecUDTUnionCaseTupleV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    String1024,
    String60,
    SCSpecUDTUnionCaseTupleV0,
    SCSpecTypeDef12,
    SCSpecTypeDef,
    SCSpecType,
    Void
  }

  describe "SCSpecUDTUnionCaseTupleV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String60.new("Hello there")

      type =
        SCSpecTypeDef12.new([
          SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_VAL)),
          SCSpecTypeDef.new(Void.new(), SCSpecType.new(:SC_SPEC_TYPE_U128))
        ])

      %{
        doc: doc,
        name: name,
        type: type,
        sc_spec_udt_union_case_tuple_v0: SCSpecUDTUnionCaseTupleV0.new(doc, name, type),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 5>>
      }
    end

    test "new/3", %{doc: doc, name: name, type: type} do
      %SCSpecUDTUnionCaseTupleV0{doc: ^doc, name: ^name, type: ^type} =
        SCSpecUDTUnionCaseTupleV0.new(doc, name, type)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_union_case_tuple_v0: sc_spec_udt_union_case_tuple_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTUnionCaseTupleV0.encode_xdr(sc_spec_udt_union_case_tuple_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_union_case_tuple_v0: sc_spec_udt_union_case_tuple_v0,
      binary: binary
    } do
      ^binary = SCSpecUDTUnionCaseTupleV0.encode_xdr!(sc_spec_udt_union_case_tuple_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_udt_union_case_tuple_v0: sc_spec_udt_union_case_tuple_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_union_case_tuple_v0, ""}} = SCSpecUDTUnionCaseTupleV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTUnionCaseTupleV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_udt_union_case_tuple_v0: sc_spec_udt_union_case_tuple_v0,
      binary: binary
    } do
      {^sc_spec_udt_union_case_tuple_v0, ^binary} =
        SCSpecUDTUnionCaseTupleV0.decode_xdr!(binary <> binary)
    end
  end
end
