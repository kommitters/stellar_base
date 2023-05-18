defmodule StellarBase.XDR.InnerTransactionResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    InnerTransactionResultExt,
    InnerTransactionResult,
    Int64,
    OperationBody,
    OperationResult,
    OperationResultCode,
    OperationResultList,
    OperationType,
    TransactionResultResult,
    TransactionResultCode,
    Void
  }

  alias StellarBase.XDR.{CreateAccountResult, CreateAccountResultCode}

  describe "InnerTransactionResult" do
    setup do
      fee_charged = Int64.new(100)

      result =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationBody.new(OperationType.new(:CREATE_ACCOUNT))
        |> OperationResult.new(OperationResultCode.new(:opINNER))
        |> (&OperationResultList.new([&1])).()
        |> TransactionResultResult.new(TransactionResultCode.new(:txSUCCESS))

      ext = InnerTransactionResultExt.new(Void.new(), 0)

      %{
        fee_charged: fee_charged,
        result: result,
        ext: ext,
        tx_result: InnerTransactionResult.new(fee_charged, result, ext),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0>>
      }
    end

    test "new/1", %{fee_charged: fee_charged, result: result, ext: ext} do
      %InnerTransactionResult{fee_charged: ^fee_charged, result: ^result, ext: ^ext} =
        InnerTransactionResult.new(fee_charged, result, ext)
    end

    test "encode_xdr/1", %{tx_result: tx_result, binary: binary} do
      {:ok, ^binary} = InnerTransactionResult.encode_xdr(tx_result)
    end

    test "encode_xdr!/1", %{tx_result: tx_result, binary: binary} do
      ^binary = InnerTransactionResult.encode_xdr!(tx_result)
    end

    test "decode_xdr/2", %{tx_result: tx_result, binary: binary} do
      {:ok, {^tx_result, ""}} = InnerTransactionResult.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InnerTransactionResult.decode_xdr(123)
    end

    test "decode_xdr!/2", %{tx_result: tx_result, binary: binary} do
      {^tx_result, ^binary} = InnerTransactionResult.decode_xdr!(binary <> binary)
    end
  end
end
