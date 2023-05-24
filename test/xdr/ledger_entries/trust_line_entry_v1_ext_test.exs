defmodule StellarBase.XDR.TrustLineEntryV1ExtTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    TrustLineEntryV1Ext,
    Void,
    Int32,
    TrustLineEntryExtensionV2,
    TrustLineEntryExtensionV2Ext
  }

  @base_data [
    %{type: 0, value: Void.new()},
    %{
      type: 2,
      value:
        TrustLineEntryExtensionV2.new(
          Int32.new(10),
          TrustLineEntryExtensionV2Ext.new(Void.new(), 0)
        )
    }
  ]

  @types [0, 2]

  describe "TrustLineEntryV1Ext" do
    setup do
      values =
        @base_data
        |> Enum.map(fn %{type: type, value: value} -> TrustLineEntryV1Ext.new(value, type) end)

      %{
        values: values,
        types: @types,
        binaries: [<<0, 0, 0, 0>>, <<0, 0, 0, 2, 0, 0, 0, 10, 0, 0, 0, 0>>]
      }
    end

    test "new/1", %{values: values, types: types} do
      for {value, type} <- Enum.zip(values, types),
          do:
            %TrustLineEntryV1Ext{value: ^value, type: ^type} =
              TrustLineEntryV1Ext.new(value, type)
    end

    test "encode_xdr/1", %{values: values, binaries: binaries} do
      for {value, binary} <- Enum.zip(values, binaries),
          do: {:ok, ^binary} = TrustLineEntryV1Ext.encode_xdr(value)
    end

    test "encode_xdr!/1", %{values: values, binaries: binaries} do
      for {value, binary} <- Enum.zip(values, binaries),
          do: ^binary = TrustLineEntryV1Ext.encode_xdr!(value)
    end

    test "decode_xdr/2", %{values: values, binaries: binaries} do
      for {value, binary} <- Enum.zip(values, binaries),
          do: {:ok, {^value, ""}} = TrustLineEntryV1Ext.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TrustLineEntryV1Ext.decode_xdr(123)
    end

    test "decode_xdr!/2", %{values: values, binaries: binaries} do
      for {value, binary} <- Enum.zip(values, binaries),
          do: {^value, ^binary} = TrustLineEntryV1Ext.decode_xdr!(binary <> binary)
    end
  end
end
