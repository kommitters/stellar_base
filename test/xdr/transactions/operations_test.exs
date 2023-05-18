defmodule StellarBase.XDR.OperationList100Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    CryptoKeyType,
    Int64,
    MuxedAccount,
    Operation,
    OperationList100,
    OperationBody,
    OperationType,
    OptionalMuxedAccount,
    PublicKey,
    PublicKeyType,
    Uint256
  }

  alias StellarBase.XDR.CreateAccountOp

  describe "OperationList100" do
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
        operations_list: [operation],
        operations: OperationList100.new([operation]),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53,
            177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42,
            171, 210, 35, 0, 0, 0, 0, 0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222,
            53, 177, 115, 224, 92, 243, 51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232,
            42, 171, 210, 35, 0, 0, 0, 1, 42, 5, 242, 0>>
      }
    end

    test "new/1", %{operations_list: operations_list} do
      %OperationList100{items: ^operations_list} = OperationList100.new(operations_list)
    end

    test "encode_xdr/1", %{operations: operations, binary: binary} do
      {:ok, ^binary} = OperationList100.encode_xdr(operations)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> OperationList100.new()
        |> OperationList100.encode_xdr()
    end

    test "encode_xdr!/1", %{operations: operations, binary: binary} do
      ^binary = OperationList100.encode_xdr!(operations)
    end

    test "decode_xdr/2", %{operations: operations, binary: binary} do
      {:ok, {^operations, ""}} = OperationList100.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OperationList100.decode_xdr(123)
    end

    test "decode_xdr!/2", %{operations: operations, binary: binary} do
      {^operations, ^binary} = OperationList100.decode_xdr!(binary <> binary)
    end
  end
end
