defmodule StellarBase.XDR.OptionalDataValueTest do
  use ExUnit.Case

  alias StellarBase.XDR.{DataValue, OptionalDataValue}

  describe "OptionalDataValue" do
    setup do
      data_value = DataValue.new("hello there")

      %{
        optional_data_value: OptionalDataValue.new(data_value),
        empty_DataValue: OptionalDataValue.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 11, 104, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101, 0>>
      }
    end

    test "new/1", %{optional_data_value: optional_data_value} do
      %OptionalDataValue{data_value: ^optional_data_value} = OptionalDataValue.new(optional_data_value)
    end

    test "new/1 no DataValue opted" do
      %OptionalDataValue{data_value: nil} = OptionalDataValue.new(nil)
    end

    test "encode_xdr/1", %{optional_data_value: optional_data_value, binary: binary} do
      {:ok, ^binary} = OptionalDataValue.encode_xdr(optional_data_value)
    end

    test "encode_xdr/1 no DataValue opted", %{empty_DataValue: empty_DataValue} do
      {:ok, <<0, 0, 0, 0>>} = OptionalDataValue.encode_xdr(empty_DataValue)
    end

    test "encode_xdr!/1", %{optional_data_value: optional_data_value, binary: binary} do
      ^binary = OptionalDataValue.encode_xdr!(optional_data_value)
    end

    test "decode_xdr/2", %{optional_data_value: optional_data_value, binary: binary} do
      {:ok, {^optional_data_value, ""}} = OptionalDataValue.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalDataValue.decode_xdr(1234)
    end

    test "decode_xdr/2 when DataValue is not opted" do
      {:ok, {%OptionalDataValue{data_value: nil}, ""}} = OptionalDataValue.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_data_value: optional_data_value, binary: binary} do
      {^optional_data_value, ^binary} = OptionalDataValue.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when DataValue is not opted" do
      {%OptionalDataValue{data_value: nil}, ""} = OptionalDataValue.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
