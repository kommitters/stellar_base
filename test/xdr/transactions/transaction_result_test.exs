defmodule Stellar.XDR.TransactionResultTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    Ext,
    Hash,
    InnerTransactionResult,
    InnerTransactionResultPair,
    Int64,
    OperationInnerResult,
    OperationResult,
    OperationResultCode,
    OperationResultList,
    OperationType,
    TxResultV0,
    TxResult,
    TransactionResult,
    TransactionResultCode,
    Void
  }

  alias Stellar.XDR.Operations.{CreateAccountResult, CreateAccountResultCode}

  describe "InnerTransactionResult" do
    setup do
      fee_charged = Int64.new(100)

      result =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationInnerResult.new(OperationType.new(:CREATE_ACCOUNT))
        |> OperationResult.new(OperationResultCode.new(:opINNER))
        |> (&OperationResultList.new([&1])).()
        |> TxResultV0.new(TransactionResultCode.new(:txSUCCESS))

      inner_tx_result = InnerTransactionResult.new(Int64.new(100), result, Ext.new())

      tx_result =
        "c61305a67fff6a82dbc6eebf1eb56a42"
        |> Hash.new()
        |> InnerTransactionResultPair.new(inner_tx_result)
        |> TxResult.new(TransactionResultCode.new(:txFEE_BUMP_INNER_SUCCESS))

      ext = Ext.new()

      %{
        fee_charged: fee_charged,
        result: tx_result,
        ext: ext,
        transaction_result: TransactionResult.new(fee_charged, tx_result, ext),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 1, 99, 54, 49, 51, 48, 53, 97, 54, 55, 102, 102,
            102, 54, 97, 56, 50, 100, 98, 99, 54, 101, 101, 98, 102, 49, 101, 98, 53, 54, 97, 52,
            50, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{fee_charged: fee_charged, result: result, ext: ext} do
      %TransactionResult{fee_charged: ^fee_charged, result: ^result, ext: ^ext} =
        TransactionResult.new(fee_charged, result, ext)
    end

    test "encode_xdr/1", %{transaction_result: transaction_result, binary: binary} do
      {:ok, ^binary} = TransactionResult.encode_xdr(transaction_result)
    end

    test "encode_xdr!/1", %{transaction_result: transaction_result, binary: binary} do
      ^binary = TransactionResult.encode_xdr!(transaction_result)
    end

    test "decode_xdr/2", %{transaction_result: transaction_result, binary: binary} do
      {:ok, {^transaction_result, ""}} = TransactionResult.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TransactionResult.decode_xdr(123)
    end

    test "decode_xdr!/2", %{transaction_result: transaction_result, binary: binary} do
      {^transaction_result, ^binary} = TransactionResult.decode_xdr!(binary <> binary)
    end
  end
end
