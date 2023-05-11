defmodule StellarBase.XDR.SCSpecUDTErrorEnumCaseV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{Uint32, SCSpecUDTErrorEnumCaseV0, String60, String1024}

  describe "SCSpecUDTErrorEnumCaseV0" do
    setup do
      doc = String1024.new("Hello there")
      name = String60.new("Hello there")
      value = Uint32.new(4_294_967_295)

      %{
        doc: doc,
        name: name,
        value: value,
        sc_spec_udt_error_enum_case_v0: SCSpecUDTErrorEnumCaseV0.new(doc, name, value),
        binary:
          <<0, 0, 0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 11, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 255, 255, 255, 255>>
      }
    end

    test "new/1", %{doc: doc, name: name, value: value} do
      %SCSpecUDTErrorEnumCaseV0{doc: ^doc, name: ^name, value: ^value} =
        SCSpecUDTErrorEnumCaseV0.new(doc, name, value)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_error_enum_case_v0: sc_spec_udt_error_enum_case_v0,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTErrorEnumCaseV0.encode_xdr(sc_spec_udt_error_enum_case_v0)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_error_enum_case_v0: sc_spec_udt_error_enum_case_v0,
      binary: binary
    } do
      ^binary = SCSpecUDTErrorEnumCaseV0.encode_xdr!(sc_spec_udt_error_enum_case_v0)
    end

    test "decode_xdr/2", %{
      sc_spec_udt_error_enum_case_v0: sc_spec_udt_error_enum_case_v0,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_error_enum_case_v0, ""}} = SCSpecUDTErrorEnumCaseV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTErrorEnumCaseV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      sc_spec_udt_error_enum_case_v0: sc_spec_udt_error_enum_case_v0,
      binary: binary
    } do
      {^sc_spec_udt_error_enum_case_v0, ^binary} =
        SCSpecUDTErrorEnumCaseV0.decode_xdr!(binary <> binary)
    end
  end
end
