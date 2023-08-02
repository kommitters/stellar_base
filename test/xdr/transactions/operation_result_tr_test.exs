defmodule StellarBase.XDR.OperationInnerResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.{OperationResultTr, OperationType, Void}

  alias StellarBase.XDR.Operations.{
    ClawbackResult,
    ClawbackResultCode,
    CreateAccountResult,
    CreateAccountResultCode,
    PaymentResult,
    PaymentResultCode,
    SetOptionsResult,
    SetOptionsResultCode
  }

  describe "CreateAccount OperationResultTr" do
    setup do
      op_type = OperationType.new(:CREATE_ACCOUNT)

      value =
        CreateAccountResult.new(Void.new(), CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))

      %{
        op_type: op_type,
        value: value,
        op_inner_value: OperationResultTr.new(value, op_type),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{value: value, op_type: op_type} do
      %OperationResultTr{value: ^value, type: ^op_type} = OperationResultTr.new(value, op_type)
    end

    test "encode_xdr/1", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, ^binary} = OperationResultTr.encode_xdr(op_inner_value)
    end

    test "encode_xdr!/1", %{op_inner_value: op_inner_value, binary: binary} do
      ^binary = OperationResultTr.encode_xdr!(op_inner_value)
    end

    test "decode_xdr/2", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, {^op_inner_value, ""}} = OperationResultTr.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_value: op_inner_value, binary: binary} do
      {^op_inner_value, ^binary} = OperationResultTr.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationResultTr.decode_xdr(123)
    end
  end

  describe "Payment OperationResultTr" do
    setup do
      op_type = OperationType.new(:PAYMENT)
      value = PaymentResult.new(Void.new(), PaymentResultCode.new(:PAYMENT_SUCCESS))

      %{
        op_type: op_type,
        value: value,
        op_inner_value: OperationResultTr.new(value, op_type),
        binary: <<0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{value: value, op_type: op_type} do
      %OperationResultTr{value: ^value, type: ^op_type} = OperationResultTr.new(value, op_type)
    end

    test "encode_xdr/1", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, ^binary} = OperationResultTr.encode_xdr(op_inner_value)
    end

    test "encode_xdr!/1", %{op_inner_value: op_inner_value, binary: binary} do
      ^binary = OperationResultTr.encode_xdr!(op_inner_value)
    end

    test "decode_xdr/2", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, {^op_inner_value, ""}} = OperationResultTr.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_value: op_inner_value, binary: binary} do
      {^op_inner_value, ^binary} = OperationResultTr.decode_xdr!(binary <> binary)
    end
  end

  describe "SetOptions OperationResultTr" do
    setup do
      op_type = OperationType.new(:SET_OPTIONS)
      value = SetOptionsResult.new(Void.new(), SetOptionsResultCode.new(:SET_OPTIONS_SUCCESS))

      %{
        op_type: op_type,
        value: value,
        op_inner_value: OperationResultTr.new(value, op_type),
        binary: <<0, 0, 0, 5, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{value: value, op_type: op_type} do
      %OperationResultTr{value: ^value, type: ^op_type} = OperationResultTr.new(value, op_type)
    end

    test "encode_xdr/1", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, ^binary} = OperationResultTr.encode_xdr(op_inner_value)
    end

    test "encode_xdr!/1", %{op_inner_value: op_inner_value, binary: binary} do
      ^binary = OperationResultTr.encode_xdr!(op_inner_value)
    end

    test "decode_xdr/2", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, {^op_inner_value, ""}} = OperationResultTr.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_value: op_inner_value, binary: binary} do
      {^op_inner_value, ^binary} = OperationResultTr.decode_xdr!(binary <> binary)
    end
  end

  describe "Clawback OperationResultTr" do
    setup do
      op_type = OperationType.new(:CLAWBACK)
      value = ClawbackResult.new(Void.new(), ClawbackResultCode.new(:CLAWBACK_SUCCESS))

      %{
        op_type: op_type,
        value: value,
        op_inner_value: OperationResultTr.new(value, op_type),
        binary: <<0, 0, 0, 19, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{value: value, op_type: op_type} do
      %OperationResultTr{value: ^value, type: ^op_type} = OperationResultTr.new(value, op_type)
    end

    test "encode_xdr/1", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, ^binary} = OperationResultTr.encode_xdr(op_inner_value)
    end

    test "encode_xdr!/1", %{op_inner_value: op_inner_value, binary: binary} do
      ^binary = OperationResultTr.encode_xdr!(op_inner_value)
    end

    test "decode_xdr/2", %{op_inner_value: op_inner_value, binary: binary} do
      {:ok, {^op_inner_value, ""}} = OperationResultTr.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_value: op_inner_value, binary: binary} do
      {^op_inner_value, ^binary} = OperationResultTr.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationResultTr.decode_xdr(123)
    end
  end
end
