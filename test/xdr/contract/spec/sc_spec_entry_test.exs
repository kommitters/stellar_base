defmodule StellarBase.XDR.SCSpecEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecEntryKind,
    SCSpecFunctionV0,
    SCSpecUDTStructV0,
    SCSpecUDTUnionV0,
    SCSpecUDTEnumV0,
    SCSpecUDTErrorEnumV0,
    SCSpecUDTUnionCaseVoidV0,
    SCSpecUDTUnionCaseV0Kind,
    SCSpecUDTUnionCaseV0,
    SCSpecUDTUnionCaseV050,
    SCSpecType,
    SCSpecTypeDef,
    Void,
    UInt32,
    SCSpecUDTEnumCaseV0,
    SCSpecUDTEnumCaseV0List,
    SCSpecUDTErrorEnumCaseV0List,
    SCSpecUDTErrorEnumCaseV0,
    String1024,
    String80,
    String60,
    String30,
    SCSymbol
  }

  describe "SCSpecEntry" do
    setup do
      doc = String1024.new("Hello there this is a test 1024")
      symbol_name = SCSymbol.new("symbol")
      lib = String80.new("Hello there 80")
      string_name_60 = String60.new("Hello there 60")
      string_name_30 = String30.new("Hello there 30")
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type = SCSpecTypeDef.new(code, type_val)
      value = UInt32.new(4_294_967_295)


      #SCSpecFunctionV0
      sc_spec_function_input_v0_1 =
        SCSpecFunctionInputV0.new(
          doc,
          string_name_30,
          type
        )

      sc_spec_function_input_v0_2 =
        SCSpecFunctionInputV0.new(
          doc,
          string_name_30,
          type
        )

      inputs =
        SCSpecFunctionInputV0List.new([
          sc_spec_function_input_v0_1,
          sc_spec_function_input_v0_2
        ])

      outputs =
        SCSpecTypeDef1.new([
          type
        ])

      #SCSpecUDTStructV0
      field = SCSpecUDTStructFieldV0.new(doc, string_name_30 , type)
      udt_struct_fields = [field, field]
      fields = SCSpecUDTStructFieldV040.new(udt_struct_fields)

      #SCSpecUDTUnionV0
      code = SCSpecUDTUnionCaseVoidV0.new(doc, name)
      kind = SCSpecUDTUnionCaseV0Kind.new(:SC_SPEC_UDT_UNION_CASE_VOID_V0)
      udt_union_case = SCSpecUDTUnionCaseV0.new(code, kind)
      udt_union_cases = [udt_union_case, udt_union_case]
      union_cases = SCSpecUDTUnionCaseV050.new(udt_union_cases)

      #SCSpecUDTEnumV0
      sc_spec_udt_enum_case_v0 = [SCSpecUDTEnumCaseV0.new(doc, string_name_60, value)]
      enum_cases = SCSpecUDTEnumCaseV0List.new(sc_spec_udt_enum_case_v0)

      #SCSpecUDTErrorEnumV0
      sc_spec_udt_error_enum_case_v0 = [SCSpecUDTErrorEnumCaseV0.new(doc, string_name_60, value)]
      enum_error_cases = SCSpecUDTErrorEnumCaseV0List.new(sc_spec_udt_error_enum_case_v0)

      discriminants = [
        %{
          sc_code: SCSpecFunctionV0.new(doc, symbol_name, inputs, outputs),
          status_kind: SCSpecEntryKind.new(:SC_SPEC_ENTRY_FUNCTION_V0),
          binary:
            <<0, 0, 0, 0, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32,
              116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11,
              72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
        },
        %{
          sc_code: SCSpecUDTStructV0.new(doc, lib, string_name_60, fields),
          status_kind: SCSpecEntryKind.new(:SC_SPEC_UDT_UNION_CASE_TUPLE_V0),
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32,
              116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11,
              72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
              0, 0, 5>>
        },
        %{
          sc_code: SCSpecUDTUnionV0.new(doc, lib, string_name_60, union_cases),
          status_kind: SCSpecEntryKind.new(:SC_SPEC_ENTRY_UDT_UNION_V0),
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32,
              116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11,
              72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
              0, 0, 5>>
        },
        %{
          sc_code: SCSpecUDTEnumV0.new(doc, lib, string_name_60, enum_cases),
          status_kind: SCSpecEntryKind.new(:SC_SPEC_ENTRY_UDT_ENUM_V0),
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32,
              116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11,
              72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
              0, 0, 5>>
        }
        %{
          sc_code: SCSpecUDTErrorEnumV0.new(doc, lib, string_name_60, enum_error_cases),
          status_kind: SCSpecEntryKind.new(:SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0),
          binary:
            <<0, 0, 0, 1, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32,
              116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11,
              72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,
              0, 0, 5>>
        }
      ]

      %{discriminants: discriminants}
    end

    test "new/2", %{discriminants: discriminants} do
      for %{status_kind: status_kind, sc_code: sc_code} <- discriminants do
        %SCSpecUDTUnionCaseV0{code: ^sc_code, kind: ^status_kind} =
          SCSpecUDTUnionCaseV0.new(sc_code, status_kind)
      end
    end

    test "encode_xdr/1", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_kind: status_kind, binary: binary} <- discriminants do
        xdr = SCSpecUDTUnionCaseV0.new(sc_code, status_kind)
        {:ok, ^binary} = SCSpecUDTUnionCaseV0.encode_xdr(xdr)
      end
    end

    test "encode_xdr!/1", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_kind: status_kind, binary: binary} <- discriminants do
        xdr = SCSpecUDTUnionCaseV0.new(sc_code, status_kind)
        ^binary = SCSpecUDTUnionCaseV0.encode_xdr!(xdr)
      end
    end

    test "decode_xdr/2", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_kind: status_kind, binary: binary} <- discriminants do
        xdr = SCSpecUDTUnionCaseV0.new(sc_code, status_kind)
        {:ok, {^xdr, ""}} = SCSpecUDTUnionCaseV0.decode_xdr(binary)
      end
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SCSpecUDTUnionCaseV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{discriminants: discriminants} do
      for %{sc_code: sc_code, status_kind: status_kind, binary: binary} <- discriminants do
        xdr = SCSpecUDTUnionCaseV0.new(sc_code, status_kind)
        {^xdr, ""} = SCSpecUDTUnionCaseV0.decode_xdr!(binary)
      end
    end
  end
end
