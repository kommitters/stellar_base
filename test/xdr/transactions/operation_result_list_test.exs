defmodule StellarBase.XDR.OperationResultListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    OperationInnerResult,
    OperationResult,
    OperationResultList,
    OperationResultCode,
    OperationType,
    Void
  }

  alias StellarBase.XDR.{CreateAccountResult, CreateAccountResultCode}

  describe "OperationResultList" do
    setup do
      code = OperationResultCode.new(:opINNER)

      op_result1 =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationInnerResult.new(OperationType.new(:CREATE_ACCOUNT))
        |> OperationResult.new(code)

      op_result2 =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationInnerResult.new(OperationType.new(:CREATE_ACCOUNT))
        |> OperationResult.new(code)

      op_results = [op_result1, op_result2]

      %{
        results: op_results,
        op_result_list: OperationResultList.new(op_results),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{results: results} do
      %OperationResultList{items: ^results} = OperationResultList.new(results)
    end

    test "encode_xdr/1", %{op_result_list: op_result_list, binary: binary} do
      {:ok, ^binary} = OperationResultList.encode_xdr(op_result_list)
    end

    test "encode_xdr!/1", %{op_result_list: op_result_list, binary: binary} do
      ^binary = OperationResultList.encode_xdr!(op_result_list)
    end

    test "decode_xdr/2", %{op_result_list: op_result_list, binary: binary} do
      {:ok, {^op_result_list, ""}} = OperationResultList.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{op_result_list: op_result_list, binary: binary} do
      {^op_result_list, ^binary} = OperationResultList.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationResultList.decode_xdr(123)
    end
  end
end
