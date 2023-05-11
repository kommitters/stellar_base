defmodule StellarBase.XDR.SCSpecUDTEnumV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecUDTEnumV0,
    SCSpecUDTEnumCaseV0,
    SCSpecUDTEnumCaseV0List50,
    String60,
    String80,
    String1024,
    Uint32
  }

  describe "SCSpecUDTEnumV0" do
    setup do
      doc = String1024.new("Hello there")
      lib = String80.new("Hello there")
      name = String60.new("Hello there")
      value = Uint32.new(4_294_967_295)
      sc_spec_udt_enum_case_v0 = [SCSpecUDTEnumCaseV0.new(doc, name, value)]
      cases = SCSpecUDTEnumCaseV0List50.new(sc_spec_udt_enum_case_v0)

      %{
        doc: doc,
        lib: lib,
        name: name,
        cases: cases,
        sc_spec_udt_enum_v0: SCSpecUDTEnumV0.new(doc, lib, name, cases),
        binary:
          <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72, 101, 108, 108,
            111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 1, 0, 0, 0, 11, 72, 101, 108, 108, 111,
            32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104,
            101, 114, 101, 0, 255, 255, 255, 255>>
      }
    end

    test "new/1", %{doc: doc, lib: lib, name: name, cases: cases} do
      %SCSpecUDTEnumV0{doc: ^doc, lib: ^lib, name: ^name, cases: ^cases} =
        SCSpecUDTEnumV0.new(doc, lib, name, cases)
    end

    test "encode_xdr/1", %{sc_spec_udt_enum_v0: sc_spec_udt_enum_v0, binary: binary} do
      {:ok, ^binary} = SCSpecUDTEnumV0.encode_xdr(sc_spec_udt_enum_v0)
    end

    test "encode_xdr!/1", %{sc_spec_udt_enum_v0: sc_spec_udt_enum_v0, binary: binary} do
      ^binary = SCSpecUDTEnumV0.encode_xdr!(sc_spec_udt_enum_v0)
    end

    test "decode_xdr/2", %{sc_spec_udt_enum_v0: sc_spec_udt_enum_v0, binary: binary} do
      {:ok, {^sc_spec_udt_enum_v0, ""}} = SCSpecUDTEnumV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTEnumV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_udt_enum_v0: sc_spec_udt_enum_v0, binary: binary} do
      {^sc_spec_udt_enum_v0, ^binary} = SCSpecUDTEnumV0.decode_xdr!(binary <> binary)
    end
  end
end
