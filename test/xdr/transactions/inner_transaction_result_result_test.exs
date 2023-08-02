defmodule StellarBase.XDR.InnerTransactionResultResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    OperationResultTr,
    OperationResult,
    OperationResultCode,
    OperationResultList,
    OperationType,
    InnerTransactionResultResult,
    TransactionResultCode,
    Void
  }

  alias StellarBase.XDR.Operations.{CreateAccountResult, CreateAccountResultCode}

  describe "InnerTransactionResultResult" do
    setup do
      op_code = OperationResultCode.new(:opINNER)

      op_result1 =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationResultTr.new(OperationType.new(:CREATE_ACCOUNT))
        |> OperationResult.new(op_code)

      op_result2 =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationResultTr.new(OperationType.new(:CREATE_ACCOUNT))
        |> OperationResult.new(op_code)

      tx_code = TransactionResultCode.new(:txSUCCESS)
      op_result_list = OperationResultList.new([op_result1, op_result2])

      %{
        code: tx_code,
        value: op_result_list,
        result: InnerTransactionResultResult.new(op_result_list, tx_code),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %InnerTransactionResultResult{value: ^value, type: ^code} =
        InnerTransactionResultResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = InnerTransactionResultResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = InnerTransactionResultResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = InnerTransactionResultResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = InnerTransactionResultResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%InnerTransactionResultResult{
         type: %TransactionResultCode{identifier: :txTOO_EARLY}
       }, ""} = InnerTransactionResultResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InnerTransactionResultResult.decode_xdr(123)
    end
  end
end
