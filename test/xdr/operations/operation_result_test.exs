defmodule Stellar.XDR.OperationResultTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    OperationInnerResult,
    OperationResult,
    OperationResultCode,
    OperationType,
    Void
  }

  alias Stellar.XDR.Operations.{CreateAccountResult, CreateAccountResultCode}

  describe "OperationResult" do
    setup do
      code = OperationResultCode.new(:opINNER)

      result =
        Void.new()
        |> CreateAccountResult.new(CreateAccountResultCode.new(:CREATE_ACCOUNT_SUCCESS))
        |> OperationInnerResult.new(OperationType.new(:CREATE_ACCOUNT))

      %{
        code: code,
        value: Void.new(),
        result: OperationResult.new(result, code),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %OperationResult{code: ^code, result: ^value} = OperationResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = OperationResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = OperationResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value" do
      code = OperationResultCode.new(:opNO_ACCOUNT)

      <<255, 255, 255, 254>> =
        "TEST"
        |> OperationResult.new(code)
        |> OperationResult.encode_xdr!()
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = OperationResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = OperationResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%OperationResult{
         code: %OperationResultCode{identifier: :opNO_ACCOUNT}
       }, ""} = OperationResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationResult.decode_xdr(123)
    end
  end
end
