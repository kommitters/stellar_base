defmodule StellarBase.XDR.OperationTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    CryptoKeyType,
    Int64,
    MuxedAccount,
    Operation,
    OperationBody,
    OperationType,
    OptionalMuxedAccount,
    PublicKey,
    PublicKeyType,
    Uint256
  }

  alias StellarBase.XDR.CreateAccountOp

  describe "Operation" do
    setup do
      pk_key =
        Uint256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      source_account =
        pk_key
        |> MuxedAccount.new(CryptoKeyType.new(:KEY_TYPE_ED25519))
        |> OptionalMuxedAccount.new()

      destination =
        pk_key
        |> PublicKey.new(PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519))
        |> AccountID.new()

      starting_balance = Int64.new(5_000_000_000)

      operation_body =
        destination
        |> CreateAccountOp.new(starting_balance)
        |> OperationBody.new(OperationType.new(:CREATE_ACCOUNT))

      operation = Operation.new(source_account, operation_body)

      %{
        source_account: source_account,
        body: operation_body,
        operation: operation,
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115,
            224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210,
            35, 0, 0, 0, 0, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177,
            115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171,
            210, 35, 0, 0, 0, 1, 42, 5, 242, 0>>
      }
    end

    test "new/1", %{source_account: source_account, body: operation_body} do
      %Operation{source_account: ^source_account, body: ^operation_body} =
        Operation.new(source_account, operation_body)
    end

    test "encode_xdr/1", %{operation: operation, binary: binary} do
      {:ok, ^binary} = Operation.encode_xdr(operation)
    end

    test "encode_xdr!/1", %{operation: operation, binary: binary} do
      ^binary = Operation.encode_xdr!(operation)
    end

    test "decode_xdr/2", %{operation: operation, binary: binary} do
      {:ok, {^operation, ""}} = Operation.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Operation.decode_xdr(123)
    end

    test "decode_xdr!/2", %{operation: operation, binary: binary} do
      {^operation, ^binary} = Operation.decode_xdr!(binary <> binary)
    end
  end
end
