defmodule StellarBase.XDR.OperationResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.OperationResultCode

  describe "OperationResultCode" do
    setup do
      %{
        code: :opINNER,
        result: OperationResultCode.new(:opINNER),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %OperationResultCode{identifier: ^type} = OperationResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = OperationResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        OperationResultCode.encode_xdr(%OperationResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = OperationResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = OperationResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = OperationResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = OperationResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%OperationResultCode{identifier: :opNO_ACCOUNT}, ""} =
        OperationResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
