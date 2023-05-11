defmodule StellarBase.XDR.TrustLineEntryExtV1ExtTest do
  use ExUnit.Case

  # alias StellarBase.XDR.{TrustLineEntryExtV1Ext, TrustLineEntryExtV2, Void, Int32, Ext}

  # @base_data [
  #   %{type: 0, value: Void.new()},
  #   %{type: 2, value: TrustLineEntryExtV2.new(Int32.new(10), Ext.new())}
  # ]

  # @types [0, 2]

  # describe "TrustLineEntryExtV1Ext" do
  #   setup do
  #     values =
  #       @base_data
  #       |> Enum.map(fn %{type: type, value: value} -> TrustLineEntryExtV1Ext.new(value, type) end)

  #     %{
  #       values: values,
  #       types: @types,
  #       binaries: [<<0, 0, 0, 0>>, <<0, 0, 0, 2, 0, 0, 0, 10, 0, 0, 0, 0>>]
  #     }
  #   end

  #   test "new/1", %{values: values, types: types} do
  #     for {value, type} <- Enum.zip(values, types),
  #         do:
  #           %TrustLineEntryExtV1Ext{value: ^value, type: ^type} =
  #             TrustLineEntryExtV1Ext.new(value, type)
  #   end

  #   test "encode_xdr/1", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: {:ok, ^binary} = TrustLineEntryExtV1Ext.encode_xdr(value)
  #   end

  #   test "encode_xdr!/1", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: ^binary = TrustLineEntryExtV1Ext.encode_xdr!(value)
  #   end

  #   test "decode_xdr/2", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: {:ok, {^value, ""}} = TrustLineEntryExtV1Ext.decode_xdr(binary)
  #   end

  #   test "decode_xdr/2 with an invalid binary" do
  #     {:error, :not_binary} = TrustLineEntryExtV1Ext.decode_xdr(123)
  #   end

  #   test "decode_xdr!/2", %{values: values, binaries: binaries} do
  #     for {value, binary} <- Enum.zip(values, binaries),
  #         do: {^value, ^binary} = TrustLineEntryExtV1Ext.decode_xdr!(binary <> binary)
  #   end
  # end
end
