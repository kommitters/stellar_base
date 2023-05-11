defmodule StellarBase.XDR.SCSpecUDTUnionCaseV0List50Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecUDTUnionCaseV0List50,
    SCSpecUDTUnionCaseV0,
    SCSpecUDTUnionCaseVoidV0,
    SCSpecUDTUnionCaseV0Kind,
    String1024,
    String60
  }

  describe "SCSpecUDTUnionCaseV0List50" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String60.new("Hello there")
      code = SCSpecUDTUnionCaseVoidV0.new(doc, name)
      kind = SCSpecUDTUnionCaseV0Kind.new(:SC_SPEC_UDT_UNION_CASE_VOID_V0)
      udt_union_case = SCSpecUDTUnionCaseV0.new(code, kind)

      sc_spec_udt_union_case_v0s = [udt_union_case, udt_union_case]

      %{
        sc_spec_udt_union_case_v0s: sc_spec_udt_union_case_v0s,
        sponsorship_descriptor_list: SCSpecUDTUnionCaseV0List50.new(sc_spec_udt_union_case_v0s),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114,
            101, 32, 116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0,
            0, 11, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 0, 0, 0, 0,
            26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 116, 104, 105, 115, 32,
            105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11, 72, 101, 108, 108, 111,
            32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1", %{sc_spec_udt_union_case_v0s: sc_spec_udt_union_case_v0s} do
      %SCSpecUDTUnionCaseV0List50{items: ^sc_spec_udt_union_case_v0s} = SCSpecUDTUnionCaseV0List50.new(sc_spec_udt_union_case_v0s)
    end

    test "encode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, ^binary} = SCSpecUDTUnionCaseV0List50.encode_xdr(sponsorship_descriptor_list)
    end

    test "encode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      ^binary = SCSpecUDTUnionCaseV0List50.encode_xdr!(sponsorship_descriptor_list)
    end

    test "decode_xdr/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {:ok, {^sponsorship_descriptor_list, ""}} = SCSpecUDTUnionCaseV0List50.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTUnionCaseV0List50.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sponsorship_descriptor_list: sponsorship_descriptor_list,
      binary: binary
    } do
      {^sponsorship_descriptor_list, ""} = SCSpecUDTUnionCaseV0List50.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecUDTUnionCaseV0List50.decode_xdr!(123) end
    end
  end
end
