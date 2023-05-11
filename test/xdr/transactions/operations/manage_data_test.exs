defmodule StellarBase.XDR.ManageDataOpTest do
  use ExUnit.Case

  alias StellarBase.XDR.{DataValue, OptionalDataValue, String64}
  alias StellarBase.XDR.ManageDataOp

  describe "ManageDataOp Operation" do
    setup do
      data_name = String64.new("HELLO")
      data_value = OptionalDataValue.new(DataValue.new("THIS IS A TEST"))

      %{
        data_name: data_name,
        data_value: data_value,
        manage_data: ManageDataOp.new(data_name, data_value),
        binary:
          <<0, 0, 0, 5, 72, 69, 76, 76, 79, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14, 84, 72, 73, 83, 32,
            73, 83, 32, 65, 32, 84, 69, 83, 84, 0, 0>>
      }
    end

    test "new/1", %{data_name: data_name, data_value: data_value} do
      %ManageDataOp{data_name: ^data_name, data_value: ^data_value} =
        ManageDataOp.new(data_name, data_value)
    end

    test "encode_xdr/1", %{manage_data: manage_data, binary: binary} do
      {:ok, ^binary} = ManageDataOp.encode_xdr(manage_data)
    end

    test "encode_xdr!/1", %{manage_data: manage_data, binary: binary} do
      ^binary = ManageDataOp.encode_xdr!(manage_data)
    end

    test "decode_xdr/2", %{manage_data: manage_data, binary: binary} do
      {:ok, {^manage_data, ""}} = ManageDataOp.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ManageDataOp.decode_xdr(123)
    end

    test "decode_xdr!/2", %{manage_data: manage_data, binary: binary} do
      {^manage_data, ^binary} = ManageDataOp.decode_xdr!(binary <> binary)
    end
  end
end
