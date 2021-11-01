defmodule Stellar.XDR.TxResultTest do
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
    TransactionResultCode,
    Void
  }

  alias Stellar.XDR.Operations.{CreateAccountResult, CreateAccountResultCode}

  setup do
    result =
      Void.new()
      |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
      |> OperationInnerResult.new(OperationType.new(:CREATE_ACCOUNT))
      |> OperationResult.new(OperationResultCode.new(:opINNER))
      |> (&OperationResultList.new([&1])).()

    {:ok, %{result: result}}
  end

  describe "txSUCCESS TransactionResult" do
    setup %{result: result} do
      code = TransactionResultCode.new(:txSUCCESS)

      %{
        code: code,
        result: result,
        tx_result: TxResult.new(result, code),
        binary: <<0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{result: result, code: code} do
      %TxResult{result: ^result, code: ^code} = TxResult.new(result, code)
    end

    test "encode_xdr/1", %{tx_result: tx_result, binary: binary} do
      {:ok, ^binary} = TxResult.encode_xdr(tx_result)
    end

    test "encode_xdr!/1", %{tx_result: tx_result, binary: binary} do
      ^binary = TxResult.encode_xdr!(tx_result)
    end

    test "decode_xdr/2", %{tx_result: tx_result, binary: binary} do
      {:ok, {^tx_result, ""}} = TxResult.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TxResult.decode_xdr(123)
    end

    test "decode_xdr!/2", %{tx_result: tx_result, binary: binary} do
      {^tx_result, ^binary} = TxResult.decode_xdr!(binary <> binary)
    end
  end

  describe "txFEE_BUMP_INNER_SUCCESS TransactionResult" do
    setup %{result: result} do
      v0_result = TxResultV0.new(result, TransactionResultCode.new(:txSUCCESS))
      inner_tx_result = InnerTransactionResult.new(Int64.new(100), v0_result, Ext.new())

      inner_tx_result_pair =
        "c61305a67fff6a82dbc6eebf1eb56a42"
        |> Hash.new()
        |> InnerTransactionResultPair.new(inner_tx_result)

      code = TransactionResultCode.new(:txFEE_BUMP_INNER_SUCCESS)

      %{
        code: code,
        result: result,
        tx_result: TxResult.new(inner_tx_result_pair, code),
        binary:
          <<0, 0, 0, 1, 99, 54, 49, 51, 48, 53, 97, 54, 55, 102, 102, 102, 54, 97, 56, 50, 100,
            98, 99, 54, 101, 101, 98, 102, 49, 101, 98, 53, 54, 97, 52, 50, 0, 0, 0, 0, 0, 0, 0,
            100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{result: result, code: code} do
      %TxResult{result: ^result, code: ^code} = TxResult.new(result, code)
    end

    test "encode_xdr/1", %{tx_result: tx_result, binary: binary} do
      {:ok, ^binary} = TxResult.encode_xdr(tx_result)
    end

    test "encode_xdr!/1", %{tx_result: tx_result, binary: binary} do
      ^binary = TxResult.encode_xdr!(tx_result)
    end

    test "decode_xdr/2", %{tx_result: tx_result, binary: binary} do
      {:ok, {^tx_result, ""}} = TxResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{tx_result: tx_result, binary: binary} do
      {^tx_result, ^binary} = TxResult.decode_xdr!(binary <> binary)
    end
  end
end
