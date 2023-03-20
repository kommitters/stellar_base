defmodule StellarBase.XDR.SCSpecUDTUnionV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    String1024,
    String60,
    String80,
    SCSpecUDTUnionCaseV050,
    SCSpecUDTUnionCaseVoidV0,
    SCSpecUDTUnionCaseV0Kind,
    SCSpecUDTUnionCaseV0,
    SCSpecUDTUnionV0
  }

  describe "SCSpecUDTUnionV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      lib = String80.new("Hello there 80")
      name = String60.new("Hello there 60")

      code = SCSpecUDTUnionCaseVoidV0.new(doc, name)
      kind = SCSpecUDTUnionCaseV0Kind.new(:SC_SPEC_UDT_UNION_CASE_VOID_V0)
      udt_union_case = SCSpecUDTUnionCaseV0.new(code, kind)
      udt_union_cases = [udt_union_case, udt_union_case]

      cases = SCSpecUDTUnionCaseV050.new(udt_union_cases)

      %{
        doc: doc,
        lib: lib,
        name: name,
        cases: cases,
        sc_spec_udt_union_v0: SCSpecUDTUnionV0.new(doc, lib, name, cases),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 32, 56, 48, 0, 0, 0, 0, 0, 14, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 32, 54, 48, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0,
            0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115,
            32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108, 108,
            111, 32, 116, 104, 101, 114, 101, 32, 54, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 72, 101,
            108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32, 105, 115, 32,
            97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 14, 72, 101, 108, 108, 111, 32, 116, 104,
            101, 114, 101, 32, 54, 48, 0, 0>>
      }
    end

    test "new/1", %{doc: doc, lib: lib, name: name, cases: cases} do
      %SCSpecUDTUnionV0{doc: ^doc, lib: ^lib, name: ^name, cases: ^cases} =
        SCSpecUDTUnionV0.new(doc, lib, name, cases)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTUnionV0.encode_xdr(sc_spec_udt_union_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      ^binary = SCSpecUDTUnionV0.encode_xdr!(sc_spec_udt_union_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_union_v0, ""}} = SCSpecUDTUnionV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTUnionV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_udt_union_v0: sc_spec_udt_union_v0,
      binary: binary
    } do
      {^sc_spec_udt_union_v0, ^binary} = SCSpecUDTUnionV0.decode_xdr!(binary <> binary)
    end
  end
end
