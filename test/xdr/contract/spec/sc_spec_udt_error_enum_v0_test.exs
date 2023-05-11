defmodule StellarBase.XDR.SCSpecUDTErrorEnumV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    Uint32,
    SCSpecUDTErrorEnumV0,
    SCSpecUDTErrorEnumCaseV0,
    SCSpecUDTErrorEnumCaseV0List50,
    String60,
    String80,
    String1024
  }

  describe "SCSpecUDTErrorEnumCaseV0" do
    setup do
      doc = String1024.new("Hello there")
      lib = String80.new("Hello there")
      name = String60.new("Hello there")
      value = Uint32.new(4_294_967_295)
      sc_spec_udt_error_enum_case_v0 = [SCSpecUDTErrorEnumCaseV0.new(doc, name, value)]
      cases = SCSpecUDTErrorEnumCaseV0List50.new(sc_spec_udt_error_enum_case_v0)

      %{
        doc: doc,
        lib: lib,
        name: name,
        cases: cases,
        sc_spec_udt_error_enum_v0: SCSpecUDTErrorEnumV0.new(doc, lib, name, cases),
        binary:
          <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72, 101, 108, 108,
            111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 1, 0, 0, 0, 11, 72, 101, 108, 108, 111,
            32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104,
            101, 114, 101, 0, 255, 255, 255, 255>>
      }
    end

    test "new/1", %{doc: doc, lib: lib, name: name, cases: cases} do
      %SCSpecUDTErrorEnumV0{doc: ^doc, lib: ^lib, name: ^name, cases: ^cases} =
        SCSpecUDTErrorEnumV0.new(doc, lib, name, cases)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_error_enum_v0: sc_spec_udt_error_enum_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTErrorEnumV0.encode_xdr(sc_spec_udt_error_enum_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_error_enum_v0: sc_spec_udt_error_enum_v0,
      binary: binary
    } do
      ^binary = SCSpecUDTErrorEnumV0.encode_xdr!(sc_spec_udt_error_enum_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_udt_error_enum_v0: sc_spec_udt_error_enum_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_error_enum_v0, ""}} = SCSpecUDTErrorEnumV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTErrorEnumV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_udt_error_enum_v0: sc_spec_udt_error_enum_v0,
      binary: binary
    } do
      {^sc_spec_udt_error_enum_v0, ^binary} = SCSpecUDTErrorEnumV0.decode_xdr!(binary <> binary)
    end
  end
end
