defmodule StellarBase.XDR.DataValueTest do
  use ExUnit.Case

  alias StellarBase.XDR.DataValue

  describe "DataValue" do
    setup do
      %{
        data_value: DataValue.new("GCIZ3GSM5"),
        binary: <<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>
      }
    end

    test "new/1" do
      %DataValue{value: data_value} =
        DataValue.new(<<0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0>>)

      16 = String.length(data_value)
    end

    test "encode_xdr/1", %{data_value: data_value, binary: binary} do
      {:ok, ^binary} = DataValue.encode_xdr(data_value)
    end

    test "encode_xdr!/1", %{data_value: data_value, binary: binary} do
      ^binary = DataValue.encode_xdr!(data_value)
    end

    test "decode_xdr/2", %{data_value: data_value, binary: binary} do
      {:ok, {^data_value, ""}} = DataValue.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = DataValue.decode_xdr(123)
    end

    test "decode_xdr!/2", %{data_value: data_value, binary: binary} do
      {^data_value, ""} = DataValue.decode_xdr!(binary)
    end

    test "invalid length" do
      {:error, :invalid_length} =
        DataValue.encode_xdr(%DataValue{
          value: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWNTMGKKUPT4V3UMXIKUS4UP64THMDZ7CZ3Z"
        })
    end
  end
end
