defmodule Stellar.XDR.OperationBodyTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    AccountID,
    Int64,
    OperationType,
    OperationBody,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  alias Stellar.XDR.Operations.CreateAccount

  describe "OperationBody" do
    setup do
      pk_key =
        UInt256.new(
          <<32, 0, 117, 126, 234, 229, 131, 252, 80, 221, 102, 159, 151, 103, 58, 204, 37, 236,
            114, 88, 35, 172, 115, 250, 246, 199, 223, 49, 173, 49, 229, 9>>
        )

      destination =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_key, &1)).()
        |> AccountID.new()

      starting_balance = Int64.new(5_000_000_000)

      operation_type = OperationType.new(:CREATE_ACCOUNT)

      create_account_op = CreateAccount.new(destination, starting_balance)

      operation_body = OperationBody.new(create_account_op, operation_type)

      %{
        operation: create_account_op,
        operation_type: operation_type,
        operation_body: operation_body,
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 32, 0, 117, 126, 234, 229, 131, 252, 80, 221, 102, 159, 151,
            103, 58, 204, 37, 236, 114, 88, 35, 172, 115, 250, 246, 199, 223, 49, 173, 49, 229, 9,
            0, 0, 0, 1, 42, 5, 242, 0>>
      }
    end

    test "new/1", %{operation: operation, operation_type: operation_type} do
      %OperationBody{operation: ^operation, type: ^operation_type} =
        OperationBody.new(operation, operation_type)
    end

    test "encode_xdr/1", %{operation_body: operation_body, binary: binary} do
      {:ok, ^binary} = OperationBody.encode_xdr(operation_body)
    end

    test "encode_xdr/1 with an invalid type", %{operation: operation} do
      operation_type = OperationType.new(:CREATE_TESTER)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     operation
                     |> OperationBody.new(operation_type)
                     |> OperationBody.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{operation_body: operation_body, binary: binary} do
      ^binary = OperationBody.encode_xdr!(operation_body)
    end

    test "decode_xdr/2", %{operation_body: operation_body, binary: binary} do
      {:ok, {^operation_body, ""}} = OperationBody.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationBody.decode_xdr(123)
    end

    test "decode_xdr!/2", %{operation_body: operation_body, binary: binary} do
      {^operation_body, ^binary} = OperationBody.decode_xdr!(binary <> binary)
    end
  end
end
