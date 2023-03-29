defmodule StellarBase.XDR.SCSpecUDTUnionCaseVoidV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{SCSpecUDTUnionCaseVoidV0, String60, String1024}

  describe "SCSpecUDTUnionCaseVoidV0" do
    setup do
      doc = String1024.new("Hello there")
      name = String60.new("Hello there")

      %{
        doc: doc,
        name: name,
        sc_spec_udt_union_case_void_v0: SCSpecUDTUnionCaseVoidV0.new(doc, name),
        binary:
          <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1", %{doc: doc, name: name} do
      %SCSpecUDTUnionCaseVoidV0{doc: ^doc, name: ^name} = SCSpecUDTUnionCaseVoidV0.new(doc, name)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_union_case_void_v0: sc_spec_udt_union_case_void_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTUnionCaseVoidV0.encode_xdr(sc_spec_udt_union_case_void_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_union_case_void_v0: sc_spec_udt_union_case_void_v0,
      binary: binary
    } do
      ^binary = SCSpecUDTUnionCaseVoidV0.encode_xdr!(sc_spec_udt_union_case_void_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_udt_union_case_void_v0: sc_spec_udt_union_case_void_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_union_case_void_v0, ""}} = SCSpecUDTUnionCaseVoidV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTUnionCaseVoidV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_udt_union_case_void_v0: sc_spec_udt_union_case_void_v0,
      binary: binary
    } do
      {^sc_spec_udt_union_case_void_v0, ^binary} =
        SCSpecUDTUnionCaseVoidV0.decode_xdr!(binary <> binary)
    end
  end
end
