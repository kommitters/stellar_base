defmodule StellarBase.XDR.SCSpecTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCSpecType

  @types [
    :SC_SPEC_TYPE_VAL,
    :SC_SPEC_TYPE_U32,
    :SC_SPEC_TYPE_I32,
    :SC_SPEC_TYPE_U64,
    :SC_SPEC_TYPE_I64,
    :SC_SPEC_TYPE_U128,
    :SC_SPEC_TYPE_I128,
    :SC_SPEC_TYPE_BOOL,
    :SC_SPEC_TYPE_SYMBOL,
    :SC_SPEC_TYPE_BITSET,
    :SC_SPEC_TYPE_STATUS,
    :SC_SPEC_TYPE_BYTES,
    :SC_SPEC_TYPE_INVOKER,
    :SC_SPEC_TYPE_ADDRESS,
    :SC_SPEC_TYPE_OPTION,
    :SC_SPEC_TYPE_RESULT,
    :SC_SPEC_TYPE_VEC,
    :SC_SPEC_TYPE_SET,
    :SC_SPEC_TYPE_MAP,
    :SC_SPEC_TYPE_TUPLE,
    :SC_SPEC_TYPE_BYTES_N,
    :SC_SPEC_TYPE_UDT
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 3>>,
    <<0, 0, 0, 4>>,
    <<0, 0, 0, 5>>,
    <<0, 0, 0, 6>>,
    <<0, 0, 0, 7>>,
    <<0, 0, 0, 8>>,
    <<0, 0, 0, 9>>,
    <<0, 0, 0, 10>>,
    <<0, 0, 0, 11>>,
    <<0, 0, 0, 12>>,
    <<0, 0, 0, 13>>,
    <<0, 0, 3, 232>>,
    <<0, 0, 3, 233>>,
    <<0, 0, 3, 234>>,
    <<0, 0, 3, 235>>,
    <<0, 0, 3, 236>>,
    <<0, 0, 3, 237>>,
    <<0, 0, 3, 238>>,
    <<0, 0, 7, 208>>
  ]

  describe "SCSpecType" do
    setup do
      %{
        types: @types,
        results: @types |> Enum.map(fn type -> SCSpecType.new(type) end),
        binaries: @binaries
      }
    end

    test "new/1", %{types: types} do
      for type <- types,
          do: %SCSpecType{identifier: ^type} = SCSpecType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SCSpecType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid type" do
      {:error, :invalid_key} = SCSpecType.encode_xdr(%SCSpecType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SCSpecType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SCSpecType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SCSpecType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SCSpecType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error type", %{binaries: binaries} do
      for binary <- binaries,
          do: {%SCSpecType{identifier: _}, ""} = SCSpecType.decode_xdr!(binary)
    end
  end
end
