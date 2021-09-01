defmodule Stellar.XDR.OperationTypeTest do
  use ExUnit.Case

  alias Stellar.XDR.OperationType

  describe "OperationType" do
    setup do
      %{
        identifier: :CREATE_ACCOUNT,
        operation_type: OperationType.new(:CREATE_ACCOUNT),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{identifier: type} do
      %OperationType{identifier: ^type} = OperationType.new(type)
    end

    test "new/1 with an invalid type" do
      %OperationType{identifier: nil} = OperationType.new(nil)
    end

    test "encode_xdr/1", %{operation_type: operation_type, binary: binary} do
      {:ok, ^binary} = OperationType.encode_xdr(operation_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} = OperationType.encode_xdr(%OperationType{identifier: :BUY_MONEY})
    end

    test "encode_xdr!/1", %{operation_type: operation_type, binary: binary} do
      ^binary = OperationType.encode_xdr!(operation_type)
    end

    test "decode_xdr/2", %{operation_type: operation_type, binary: binary} do
      {:ok, {^operation_type, ""}} = OperationType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = OperationType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{operation_type: operation_type, binary: binary} do
      {^operation_type, ^binary} = OperationType.decode_xdr!(binary <> binary)
    end
  end
end
