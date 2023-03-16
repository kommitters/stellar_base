defmodule StellarBase.XDR.SCSpecUDTErrorEnumCaseV0ListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecUDTErrorEnumCaseV0List,
    SCSpecUDTErrorEnumCaseV0,
    String1024,
    String60,
    UInt32
  }

  describe "SCSpecUDTErrorEnumCaseV0List" do
    setup do
      doc1 = String1024.new("Hello there 1")
      name1 = String60.new("Hello there 1")
      value1 = UInt32.new(4_294_967_295)

      doc2 = String1024.new("Hello there 2")
      name2 = String60.new("Hello there 2")
      value2 = UInt32.new(1_234_567_890)

      sc_spec_udt_error_enum_case_v0_1 = SCSpecUDTErrorEnumCaseV0.new(doc1, name1, value1)
      sc_spec_udt_error_enum_case_v0_2 = SCSpecUDTErrorEnumCaseV0.new(doc2, name2, value2)

      cases = [sc_spec_udt_error_enum_case_v0_1, sc_spec_udt_error_enum_case_v0_2]

      %{
        cases: cases,
        sc_spec_udt_error_enum_case_v0_list: SCSpecUDTErrorEnumCaseV0List.new(cases),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 13, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 49,
            0, 0, 0, 0, 0, 0, 13, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32, 49, 0,
            0, 0, 255, 255, 255, 255, 0, 0, 0, 13, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114,
            101, 32, 50, 0, 0, 0, 0, 0, 0, 13, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114,
            101, 32, 50, 0, 0, 0, 73, 150, 2, 210>>
      }
    end

    test "new/1", %{cases: cases} do
      %SCSpecUDTErrorEnumCaseV0List{cases: ^cases} = SCSpecUDTErrorEnumCaseV0List.new(cases)
    end

    test "encode_xdr/1", %{
      sc_spec_udt_error_enum_case_v0_list: sc_spec_udt_error_enum_case_v0_list,
      binary: binary
    } do
      {:ok, ^binary} =
        SCSpecUDTErrorEnumCaseV0List.encode_xdr(sc_spec_udt_error_enum_case_v0_list)
    end

    test "encode_xdr!/1", %{
      sc_spec_udt_error_enum_case_v0_list: sc_spec_udt_error_enum_case_v0_list,
      binary: binary
    } do
      ^binary = SCSpecUDTErrorEnumCaseV0List.encode_xdr!(sc_spec_udt_error_enum_case_v0_list)
    end

    test "decode_xdr/1", %{
      sc_spec_udt_error_enum_case_v0_list: sc_spec_udt_error_enum_case_v0_list,
      binary: binary
    } do
      {:ok, {^sc_spec_udt_error_enum_case_v0_list, ""}} =
        SCSpecUDTErrorEnumCaseV0List.decode_xdr(binary)
    end

    test "decode_xdr/1 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTErrorEnumCaseV0List.decode_xdr(123)
    end

    test "decode_xdr!/1", %{
      sc_spec_udt_error_enum_case_v0_list: sc_spec_udt_error_enum_case_v0_list,
      binary: binary
    } do
      {^sc_spec_udt_error_enum_case_v0_list, ""} =
        SCSpecUDTErrorEnumCaseV0List.decode_xdr!(binary)
    end

    test "decode_xdr!/1 with an invalid binary" do
      assert_raise XDR.VariableArrayError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn -> SCSpecUDTErrorEnumCaseV0List.decode_xdr!(123) end
    end
  end
end
