defmodule StellarBase.XDR.SCSpecUDTUnionCaseV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    SCSpecUDTUnionCaseVoidV0,
    SCSpecUDTUnionCaseTupleV0,
    SCSpecUDTUnionCaseV0Kind,
    SCSpecUDTUnionCaseV0,
    String1024,
    String60,
    Void,
    SCSpecTypeDef12,
    SCSpecTypeDef,
    SCSpecType
  }

  describe "SCSpecUDTUnionCaseV0" do
    setup do
      doc = String1024.new("Hello there this is a test")
      name = String60.new("Hello there")
      code = Void.new()
      type_val = SCSpecType.new(:SC_SPEC_TYPE_VAL)
      type_u128 = SCSpecType.new(:SC_SPEC_TYPE_U128)
      sc_spec_type_def1 = SCSpecTypeDef.new(code, type_val)
      sc_spec_type_def2 = SCSpecTypeDef.new(code, type_u128)

      type = SCSpecTypeDef12.new([sc_spec_type_def1, sc_spec_type_def2])

      discriminants = [
        %{
          sc_code: SCSpecUDTUnionCaseVoidV0.new(doc, name),
          status_kind: SCSpecUDTUnionCaseV0Kind.new(:SC_SPEC_UDT_UNION_CASE_VOID_V0),
          binary:
            <<0, 0, 0, 0, 0, 0, 0, 26, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 32,
              116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116, 0, 0, 0, 0, 0, 11,
              72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
        },
        %{
          sc_code: SCSpecUDTUnionCaseTupleV0.new(doc, name, type),
          status_kind: SCSpecUDTUnionCaseV0Kind.new(:SC_SPEC_UDT_UNION_CASE_TUPLE_V0),
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
