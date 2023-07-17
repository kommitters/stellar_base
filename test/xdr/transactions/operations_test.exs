defmodule StellarBase.XDR.OperationsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    CryptoKeyType,
    CreateAccount,
    Int64,
    MuxedAccount,
    Operation,
    Operations,
    OperationBody,
    OperationType,
    OptionalMuxedAccount,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  describe "Operations" do
    setup do
      pk_key =
        UInt256.new(
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
        |> CreateAccount.new(starting_balance)
        |> OperationBody.new(OperationType.new(:CREATE_ACCOUNT))

      operation = Operation.new(operation_body, source_account)

      %{
        operations_list: [operation],
        operations: Operations.new([operation]),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53,
            177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42,
            171, 210, 35, 0, 0, 0, 0, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222,
            53, 177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232,
            42, 171, 210, 35, 0, 0, 0, 1, 42, 5, 242, 0>>
      }
    end

    test "new/1", %{operations_list: operations_list} do
      %Operations{operations: ^operations_list} = Operations.new(operations_list)
    end

    test "encode_xdr/1", %{operations: operations, binary: binary} do
      {:ok, ^binary} = Operations.encode_xdr(operations)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> Operations.new()
        |> Operations.encode_xdr()
    end

    test "encode_xdr!/1", %{operations: operations, binary: binary} do
      ^binary = Operations.encode_xdr!(operations)
    end

    test "decode_xdr/2", %{operations: operations, binary: binary} do
      {:ok, {^operations, ""}} = Operations.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Operations.decode_xdr(123)
    end

    test "decode_xdr!/2", %{operations: operations, binary: binary} do
      {^operations, ^binary} = Operations.decode_xdr!(binary <> binary)
    end
  end
end
