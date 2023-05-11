defmodule StellarBase.XDR.SCSpecUDTEnumCaseV0List50Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecUDTEnumCaseV0,
    SCSpecUDTEnumCaseV0List50,
    Uint32,
    String1024,
    String60
  }

  describe "SCSpecUDTEnumCaseV0List50" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String60.new("Hello there")
      value = Uint32.new(4_294_967_295)
      sc_spec_udt_enum_case_v0_1 = SCSpecUDTEnumCaseV0.new(doc, name, value)

      doc2 = String1024.new("Hello there this is a test")
      name2 = String60.new("Hello there")
      value2 = Uint32.new(4_294_967_295)
      sc_spec_udt_enum_case_v0_2 = SCSpecUDTEnumCaseV0.new(doc2, name2, value2)

      sc_spec_udt_enum_case_v0s = [sc_spec_udt_enum_case_v0_1, sc_spec_udt_enum_case_v0_2]

      %{
        sc_spec_udt_enum_case_v0s: sc_spec_udt_enum_case_v0s,
        sc_spec_udt_enum_case_v0_list: SCSpecUDTEnumCaseV0List50.new(sc_spec_udt_enum_case_v0s),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116,
            104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72,
            101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 255, 255, 255, 255, 0, 0, 0, 26,
            72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32, 105,
            115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72, 101, 108, 108, 111, 32,
            116, 104, 101, 114, 101, 0, 255, 255, 255, 255>>
      }
    end

    test "new/1", %{sc_spec_udt_enum_case_v0s: sc_spec_udt_enum_case_v0s} do
      %SCSpecUDTEnumCaseV0List50{items: ^sc_spec_udt_enum_case_v0s} =
        SCSpecUDTEnumCaseV0List50.new(sc_spec_udt_enum_case_v0s)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_enum_case_v0_list: sc_spec_udt_enum_case_v0_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTEnumCaseV0List50.encode_xdr(sc_spec_udt_enum_case_v0_list)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_enum_case_v0_list: sc_spec_udt_enum_case_v0_list,
      binary: binary
    } do
      ^binary = SCSpecUDTEnumCaseV0List50.encode_xdr!(sc_spec_udt_enum_case_v0_list)
    end

    test "decode_xdr/1", %{
      sc_spec_udt_enum_case_v0_list: sc_spec_udt_enum_case_v0_list,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_enum_case_v0_list, ""}} = SCSpecUDTEnumCaseV0List50.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTEnumCaseV0List50.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sc_spec_udt_enum_case_v0_list: sc_spec_udt_enum_case_v0_list,
      binary: binary
    } do
      {^sc_spec_udt_enum_case_v0_list, ""} = SCSpecUDTEnumCaseV0List50.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecUDTEnumCaseV0List50.decode_xdr!(123) end
    end
  end
end
