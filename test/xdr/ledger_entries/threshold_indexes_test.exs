defmodule StellarBase.XDR.ThresholdIndexesTest do
  use ExUnit.Case

  alias StellarBase.XDR.ThresholdIndexes

  @identifiers [
    :THRESHOLD_MASTER_WEIGHT,
    :THRESHOLD_LOW,
    :THRESHOLD_MED,
    :THRESHOLD_HIGH
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 3>>
  ]

  describe "ThresholdIndexes" do
    setup do
      %{
        identifiers: @identifiers,
        operation_types:
          @identifiers |> Enum.map(fn identifier -> ThresholdIndexes.new(identifier) end),
        binaries: @binaries
      }
    end

    test "new/1", %{identifiers: types} do
      for type <- types, do: %ThresholdIndexes{identifier: ^type} = ThresholdIndexes.new(type)
    end

    test "new/1 with an invalid type" do
      %ThresholdIndexes{identifier: nil} = ThresholdIndexes.new(nil)
    end

    test "encode_xdr/1", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {:ok, ^binary} = ThresholdIndexes.encode_xdr(operation_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} =
        ThresholdIndexes.encode_xdr(%ThresholdIndexes{identifier: :INDEFINITE_THRESHOLD})
    end

    test "encode_xdr!/1", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: ^binary = ThresholdIndexes.encode_xdr!(operation_type)
    end

    test "decode_xdr/2", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {:ok, {^operation_type, ""}} = ThresholdIndexes.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ThresholdIndexes.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{operation_types: operation_types, binaries: binaries} do
      for {operation_type, binary} <- Enum.zip(operation_types, binaries),
          do: {^operation_type, ^binary} = ThresholdIndexes.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%ThresholdIndexes{identifier: _}, ""} = ThresholdIndexes.decode_xdr!(binary)
    end
  end
end
