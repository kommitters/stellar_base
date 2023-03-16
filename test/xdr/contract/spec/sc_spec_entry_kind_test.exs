defmodule StellarBase.XDR.SCSpecEntryKindTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCSpecEntryKind

  @types [
    :SC_SPEC_ENTRY_FUNCTION_V0,
    :SC_SPEC_ENTRY_UDT_STRUCT_V0,
    :SC_SPEC_ENTRY_UDT_UNION_V0,
    :SC_SPEC_ENTRY_UDT_ENUM_V0,
    :SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 3>>,
    <<0, 0, 0, 4>>
  ]

  describe "SCSpecEntryKind" do
    setup do
      %{
        types: @types,
        results: @types |> Enum.map(fn type -> SCSpecEntryKind.new(type) end),
        binaries: @binaries
      }
    end

    test "new/1", %{types: types} do
      for type <- types,
          do: %SCSpecEntryKind{identifier: ^type} = SCSpecEntryKind.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SCSpecEntryKind.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid type" do
      {:error, :invalid_key} = SCSpecEntryKind.encode_xdr(%SCSpecEntryKind{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SCSpecEntryKind.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SCSpecEntryKind.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SCSpecEntryKind.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SCSpecEntryKind.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error type", %{binaries: binaries} do
      for binary <- binaries,
          do: {%SCSpecEntryKind{identifier: _}, ""} = SCSpecEntryKind.decode_xdr!(binary)
    end
  end
end
