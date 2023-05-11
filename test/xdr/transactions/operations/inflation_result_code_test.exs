defmodule StellarBase.XDR.InflationResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.InflationResultCode

  @codes [
    :INFLATION_SUCCESS,
    :INFLATION_NOT_TIME
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>
  ]

  describe "InflationResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> InflationResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %InflationResultCode{identifier: ^type} = InflationResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = InflationResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        InflationResultCode.encode_xdr(%InflationResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = InflationResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = InflationResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = InflationResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = InflationResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%InflationResultCode{identifier: _}, ""} = InflationResultCode.decode_xdr!(binary)
    end
  end
end
