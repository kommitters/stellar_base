defmodule Stellar.XDR.Operations.OperationInnerResult do
  use ExUnit.Case

  alias Stellar.XDR.{OperationInnerResult, OperationType, Void}

  alias Stellar.XDR.Operations.{
    ClawbackResult,
    ClawbackResultCode,
    CreateAccountResult,
    CreateAccountResultCode,
    PaymentResult,
    PaymentResultCode,
    SetOptionsResult,
    SetOptionsResultCode
  }

  describe "CreateAccount OperationInnerResult" do
    setup do
      op_type = OperationType.new(:CREATE_ACCOUNT)

      result =
        CreateAccountResult.new(Void.new(), CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))

      %{
        op_type: op_type,
        result: result,
        op_inner_result: OperationInnerResult.new(result, op_type),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{result: result, op_type: op_type} do
      %OperationInnerResult{result: ^result, type: ^op_type} =
        OperationInnerResult.new(result, op_type)
    end

    test "encode_xdr/1", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, ^binary} = OperationInnerResult.encode_xdr(op_inner_result)
    end

    test "encode_xdr!/1", %{op_inner_result: op_inner_result, binary: binary} do
      ^binary = OperationInnerResult.encode_xdr!(op_inner_result)
    end

    test "decode_xdr/2", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, {^op_inner_result, ""}} = OperationInnerResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_result: op_inner_result, binary: binary} do
      {^op_inner_result, ^binary} = OperationInnerResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationInnerResult.decode_xdr(123)
    end
  end

  describe "Payment OperationInnerResult" do
    setup do
      op_type = OperationType.new(:PAYMENT)
      result = PaymentResult.new(Void.new(), PaymentResultCode.new(:PAYMENT_SUCCESS))

      %{
        op_type: op_type,
        result: result,
        op_inner_result: OperationInnerResult.new(result, op_type),
        binary: <<0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{result: result, op_type: op_type} do
      %OperationInnerResult{result: ^result, type: ^op_type} =
        OperationInnerResult.new(result, op_type)
    end

    test "encode_xdr/1", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, ^binary} = OperationInnerResult.encode_xdr(op_inner_result)
    end

    test "encode_xdr!/1", %{op_inner_result: op_inner_result, binary: binary} do
      ^binary = OperationInnerResult.encode_xdr!(op_inner_result)
    end

    test "decode_xdr/2", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, {^op_inner_result, ""}} = OperationInnerResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_result: op_inner_result, binary: binary} do
      {^op_inner_result, ^binary} = OperationInnerResult.decode_xdr!(binary <> binary)
    end
  end

  describe "SetOptions OperationInnerResult" do
    setup do
      op_type = OperationType.new(:SET_OPTIONS)
      result = SetOptionsResult.new(Void.new(), SetOptionsResultCode.new(:SET_OPTIONS_SUCCESS))

      %{
        op_type: op_type,
        result: result,
        op_inner_result: OperationInnerResult.new(result, op_type),
        binary: <<0, 0, 0, 5, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{result: result, op_type: op_type} do
      %OperationInnerResult{result: ^result, type: ^op_type} =
        OperationInnerResult.new(result, op_type)
    end

    test "encode_xdr/1", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, ^binary} = OperationInnerResult.encode_xdr(op_inner_result)
    end

    test "encode_xdr!/1", %{op_inner_result: op_inner_result, binary: binary} do
      ^binary = OperationInnerResult.encode_xdr!(op_inner_result)
    end

    test "decode_xdr/2", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, {^op_inner_result, ""}} = OperationInnerResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_result: op_inner_result, binary: binary} do
      {^op_inner_result, ^binary} = OperationInnerResult.decode_xdr!(binary <> binary)
    end
  end

  describe "Clawback OperationInnerResult" do
    setup do
      op_type = OperationType.new(:CLAWBACK)
      result = ClawbackResult.new(Void.new(), ClawbackResultCode.new(:CLAWBACK_SUCCESS))

      %{
        op_type: op_type,
        result: result,
        op_inner_result: OperationInnerResult.new(result, op_type),
        binary: <<0, 0, 0, 19, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{result: result, op_type: op_type} do
      %OperationInnerResult{result: ^result, type: ^op_type} =
        OperationInnerResult.new(result, op_type)
    end

    test "encode_xdr/1", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, ^binary} = OperationInnerResult.encode_xdr(op_inner_result)
    end

    test "encode_xdr!/1", %{op_inner_result: op_inner_result, binary: binary} do
      ^binary = OperationInnerResult.encode_xdr!(op_inner_result)
    end

    test "decode_xdr/2", %{op_inner_result: op_inner_result, binary: binary} do
      {:ok, {^op_inner_result, ""}} = OperationInnerResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_inner_result: op_inner_result, binary: binary} do
      {^op_inner_result, ^binary} = OperationInnerResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationInnerResult.decode_xdr(123)
    end
  end
end
