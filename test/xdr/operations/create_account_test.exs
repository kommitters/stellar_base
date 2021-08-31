defmodule Stellar.XDR.Operations.CreateAccountTest do
  use ExUnit.Case

  alias Stellar.XDR.{AccountID, Int64, PublicKey, PublicKeyType, UInt256}
  alias Stellar.XDR.Operations.CreateAccount

  describe "CreateAccount" do
    setup do
      pk_key =
        UInt256.new(
          <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
            249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        )

      destination =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(pk_key, &1)).()
        |> AccountID.new()

      starting_balance = Int64.new(5_000_000_000)

      create_account = CreateAccount.new(destination, starting_balance)

      %{
        destination: destination,
        starting_balance: starting_balance,
        create_account: create_account,
        binary:
          <<0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243,
            51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35, 0, 0, 0, 1,
            42, 5, 242, 0>>
      }
    end

    test "new/1", %{destination: destination, starting_balance: starting_balance} do
      %CreateAccount{destination: ^destination, starting_balance: ^starting_balance} =
        CreateAccount.new(destination, starting_balance)
    end

    test "encode_xdr/1", %{create_account: create_account, binary: binary} do
      {:ok, ^binary} = CreateAccount.encode_xdr(create_account)
    end

    test "encode_xdr!/1", %{create_account: create_account, binary: binary} do
      ^binary = CreateAccount.encode_xdr!(create_account)
    end

    test "decode_xdr/2", %{create_account: create_account, binary: binary} do
      {:ok, {^create_account, ""}} = CreateAccount.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreateAccount.decode_xdr(123)
    end

    test "decode_xdr!/2", %{create_account: create_account, binary: binary} do
      {^create_account, ^binary} = CreateAccount.decode_xdr!(binary <> binary)
    end
  end
end
