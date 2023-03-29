defmodule StellarBase.XDR.SCSpecUDTEnumCaseV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{String1024, String60, SCSpecUDTEnumCaseV0, UInt32}

  describe "SCSpecUDTEnumCaseV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String60.new("Hello there")
      value = UInt32.new(4_294_967_295)

      %{
        doc: doc,
        name: name,
        value: value,
        sc_spec_udt_enum_case_v0: SCSpecUDTEnumCaseV0.new(doc, name, value),
        binary:
          <<0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105,
            115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72, 101, 108,
            108, 111, 32, 116, 104, 101, 114, 101, 0, 255, 255, 255, 255>>
      }
    end

    test "new/1", %{doc: doc, name: name, value: value} do
      %SCSpecUDTEnumCaseV0{doc: ^doc, name: ^name, value: ^value} =
        SCSpecUDTEnumCaseV0.new(doc, name, value)
    end

    test "encode_xdr/1", %{sc_spec_udt_enum_case_v0: sc_spec_udt_enum_case_v0, binary: binary} do
      {:ok, ^binary} = SCSpecUDTEnumCaseV0.encode_xdr(sc_spec_udt_enum_case_v0)
    end

    test "encode_xdr!/1", %{sc_spec_udt_enum_case_v0: sc_spec_udt_enum_case_v0, binary: binary} do
      ^binary = SCSpecUDTEnumCaseV0.encode_xdr!(sc_spec_udt_enum_case_v0)
    end

    test "decode_xdr/2", %{sc_spec_udt_enum_case_v0: sc_spec_udt_enum_case_v0, binary: binary} do
      {:ok, {^sc_spec_udt_enum_case_v0, ""}} = SCSpecUDTEnumCaseV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTEnumCaseV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{sc_spec_udt_enum_case_v0: sc_spec_udt_enum_case_v0, binary: binary} do
      {^sc_spec_udt_enum_case_v0, ^binary} = SCSpecUDTEnumCaseV0.decode_xdr!(binary <> binary)
    end
  end
end
