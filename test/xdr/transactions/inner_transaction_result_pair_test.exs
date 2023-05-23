defmodule StellarBase.XDR.InnerTransactionResultPairTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    InnerTransactionResultExt,
    Hash,
    InnerTransactionResult,
    InnerTransactionResultPair,
    Int64,
    OperationBody,
    OperationResult,
    OperationResultCode,
    OperationResultList,
    OperationResultTr,
    OperationType,
    InnerTransactionResultResult,
    TransactionResultCode,
    Void
  }

  alias StellarBase.XDR.{CreateAccountResult, CreateAccountResultCode}

  describe "InnerTransactionResultPair" do
    setup do
      transaction_result_code = TransactionResultCode.new(:txSUCCESS)

      result =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationResultTr.new(OperationType.new(:CREATE_ACCOUNT))
        |> OperationResult.new(OperationResultCode.new(:opINNER))
        |> (&OperationResultList.new([&1])).()
        |> InnerTransactionResultResult.new(transaction_result_code)

      transaction_hash = Hash.new("c61305a67fff6a82dbc6eebf1eb56a42")

      inner_tx_result =
        InnerTransactionResult.new(
          Int64.new(100),
          result,
          InnerTransactionResultExt.new(Void.new(), 0)
        )

      %{
        transaction_hash: transaction_hash,
        inner_tx_result: inner_tx_result,
        inner_tx_result_pair: InnerTransactionResultPair.new(transaction_hash, inner_tx_result),
        binary:
          <<99, 54, 49, 51, 48, 53, 97, 54, 55, 102, 102, 102, 54, 97, 56, 50, 100, 98, 99, 54,
            101, 101, 98, 102, 49, 101, 98, 53, 54, 97, 52, 50, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0,
            0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{transaction_hash: transaction_hash, inner_tx_result: result} do
      %InnerTransactionResultPair{transaction_hash: ^transaction_hash, result: ^result} =
        InnerTransactionResultPair.new(transaction_hash, result)
    end

    test "encode_xdr/1", %{inner_tx_result_pair: inner_tx_result_pair, binary: binary} do
      {:ok, ^binary} = InnerTransactionResultPair.encode_xdr(inner_tx_result_pair)
    end

    test "encode_xdr!/1", %{inner_tx_result_pair: inner_tx_result_pair, binary: binary} do
      ^binary = InnerTransactionResultPair.encode_xdr!(inner_tx_result_pair)
    end

    test "decode_xdr/2", %{inner_tx_result_pair: inner_tx_result_pair, binary: binary} do
      {:ok, {^inner_tx_result_pair, ""}} = InnerTransactionResultPair.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = InnerTransactionResultPair.decode_xdr(123)
    end

    test "decode_xdr!/2", %{inner_tx_result_pair: inner_tx_result_pair, binary: binary} do
      {^inner_tx_result_pair, ^binary} = InnerTransactionResultPair.decode_xdr!(binary <> binary)
    end
  end
end
