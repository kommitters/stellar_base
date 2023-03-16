defmodule StellarBase.XDR.SCSpecUDTUnionCaseV0KindTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCSpecUDTUnionCaseV0Kind

  @types [
    :SC_SPEC_UDT_UNION_CASE_VOID_V0,
    :SC_SPEC_UDT_UNION_CASE_TUPLE_V0
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>
  ]

  describe "SCSpecUDTUnionCaseV0Kind" do
    setup do
      %{
        types: @types,
        results: Enum.map(@types, &SCSpecUDTUnionCaseV0Kind.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{types: types} do
      for type <- types,
          do: %SCSpecUDTUnionCaseV0Kind{identifier: ^type} = SCSpecUDTUnionCaseV0Kind.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SCSpecUDTUnionCaseV0Kind.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid type" do
      {:error, :invalid_key} =
        SCSpecUDTUnionCaseV0Kind.encode_xdr(%SCSpecUDTUnionCaseV0Kind{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SCSpecUDTUnionCaseV0Kind.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SCSpecUDTUnionCaseV0Kind.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SCSpecUDTUnionCaseV0Kind.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SCSpecUDTUnionCaseV0Kind.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error type", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%SCSpecUDTUnionCaseV0Kind{identifier: _}, ""} =
              SCSpecUDTUnionCaseV0Kind.decode_xdr!(binary)
    end
  end
end
