defmodule Stellar.XDR.OperationsTest do
  use ExUnit.Case

  alias Stellar.XDR.{
    AccountID,
    CryptoKeyType,
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

  alias Stellar.XDR.Operations.CreateAccount

  describe "Operations" do
    setup do
      pk_key =
        UInt256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      source_account =
        CryptoKeyType.new(:KEY_TYPE_ED25519)
        |> MuxedAccount.new(pk_key)
        |> OptionalMuxedAccount.new()

      destination =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_key, &1)).()
        |> AccountID.new()

      starting_balance = Int64.new(5_000_000_000)

      operation_body =
        destination
        |> CreateAccount.new(starting_balance)
        |> OperationBody.new(OperationType.new(:CREATE_ACCOUNT))

      operation = Operation.new(source_account, operation_body)

      %{
        elements: [operation, operation],
        operations: Operations.new([operation, operation]),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53,
            177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42,
            171, 210, 35, 0, 0, 0, 0, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222,
            53, 177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232,
            42, 171, 210, 35, 0, 0, 0, 1, 42, 5, 242, 0, 0, 0, 0, 1, 0, 0, 0, 0, 18, 27, 249, 51,
            160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78,
            128, 109, 86, 239, 171, 232, 42, 171, 210, 35, 0, 0, 0, 0, 0, 0, 0, 0, 18, 27, 249,
            51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242, 249, 40, 118,
            78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35, 0, 0, 0, 1, 42, 5, 242, 0>>
      }
    end

    test "new/1", %{elements: elements} do
      %Operations{operations: ^elements} = Operations.new(elements)
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
