defmodule StellarBase.XDR.Operations.ExtendFootprintTTLResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.ExtendFootprintTTLResultCode

  @codes [
    :EXTEND_FOOTPRINT_TTL_SUCCESS,
    :EXTEND_FOOTPRINT_TTL_MALFORMED,
    :EXTEND_FOOTPRINT_TTL_RESOURCE_LIMIT_EXCEEDED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>
  ]

  describe "ExtendFootprintTTLResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> ExtendFootprintTTLResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %ExtendFootprintTTLResultCode{identifier: ^type} =
              ExtendFootprintTTLResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ExtendFootprintTTLResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ExtendFootprintTTLResultCode.encode_xdr(%ExtendFootprintTTLResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ExtendFootprintTTLResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ExtendFootprintTTLResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ExtendFootprintTTLResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = ExtendFootprintTTLResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%ExtendFootprintTTLResultCode{identifier: _}, ""} =
              ExtendFootprintTTLResultCode.decode_xdr!(binary)
    end
  end
end
