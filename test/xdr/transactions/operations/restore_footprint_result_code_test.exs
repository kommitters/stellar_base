defmodule StellarBase.XDR.Operations.RestoreFootprintResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.RestoreFootprintResultCode

  @codes [
    :RESTORE_FOOTPRINT_SUCCESS,
    :RESTORE_FOOTPRINT_MALFORMED,
    :RESTORE_FOOTPRINT_RESOURCE_LIMIT_EXCEEDED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>
  ]

  describe "RestoreFootprintResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> RestoreFootprintResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %RestoreFootprintResultCode{identifier: ^type} = RestoreFootprintResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = RestoreFootprintResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        RestoreFootprintResultCode.encode_xdr(%RestoreFootprintResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = RestoreFootprintResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = RestoreFootprintResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = RestoreFootprintResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = RestoreFootprintResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%RestoreFootprintResultCode{identifier: _}, ""} =
              RestoreFootprintResultCode.decode_xdr!(binary)
    end
  end
end
