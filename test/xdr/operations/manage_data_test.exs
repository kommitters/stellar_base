defmodule Stellar.XDR.Operations.ManageDataTest do
  use ExUnit.Case

  alias Stellar.XDR.{DataValue, OptionalDataValue, String64}
  alias Stellar.XDR.Operations.ManageData

  describe "ManageData Operation" do
    setup do
      data_name = String64.new("HELLO")
      data_value = OptionalDataValue.new(DataValue.new("THIS IS A TEST"))

      %{
        data_name: data_name,
        data_value: data_value,
        manage_data: ManageData.new(data_name, data_value),
        binary:
          <<0, 0, 0, 5, 72, 69, 76, 76, 79, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14, 84, 72, 73, 83, 32,
            73, 83, 32, 65, 32, 84, 69, 83, 84, 0, 0>>
      }
    end

    test "new/1", %{data_name: data_name, data_value: data_value} do
      %ManageData{data_name: ^data_name, data_value: ^data_value} =
        ManageData.new(data_name, data_value)
    end

    test "encode_xdr/1", %{manage_data: manage_data, binary: binary} do
      {:ok, ^binary} = ManageData.encode_xdr(manage_data)
    end

    test "encode_xdr!/1", %{manage_data: manage_data, binary: binary} do
      ^binary = ManageData.encode_xdr!(manage_data)
    end

    test "decode_xdr/2", %{manage_data: manage_data, binary: binary} do
      {:ok, {^manage_data, ""}} = ManageData.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ManageData.decode_xdr(123)
    end

    test "decode_xdr!/2", %{manage_data: manage_data, binary: binary} do
      {^manage_data, ^binary} = ManageData.decode_xdr!(binary <> binary)
    end
  end
end
