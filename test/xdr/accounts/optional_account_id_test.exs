defmodule Stellar.XDR.OptionalAccountIDTest do
  use ExUnit.Case

  alias Stellar.XDR.{AccountID, OptionalAccountID, PublicKey, PublicKeyType, UInt256}

  describe "OptionalAccountID" do
    setup do
      public_key =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> Stellar.Ed25519.PublicKey.decode!()
        |> UInt256.new()

      account_id =
        PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
        |> (&PublicKey.new(public_key, &1)).()
        |> AccountID.new()

      %{
        optional_account_id: OptionalAccountID.new(account_id),
        empty_account_id: OptionalAccountID.new(nil),
        binary:
          <<0, 0, 0, 1, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227,
            119>>
      }
    end

    test "new/1", %{optional_account_id: optional_account_id} do
      %OptionalAccountID{account_id: ^optional_account_id} =
        OptionalAccountID.new(optional_account_id)
    end

    test "new/1 no account_id opted" do
      %OptionalAccountID{account_id: nil} = OptionalAccountID.new(nil)
    end

    test "encode_xdr/1", %{optional_account_id: optional_account_id, binary: binary} do
      {:ok, ^binary} = OptionalAccountID.encode_xdr(optional_account_id)
    end

    test "encode_xdr/1 no account_id opted", %{empty_account_id: empty_account_id} do
      {:ok, <<0, 0, 0, 0>>} = OptionalAccountID.encode_xdr(empty_account_id)
    end

    test "encode_xdr!/1", %{optional_account_id: optional_account_id, binary: binary} do
      ^binary = OptionalAccountID.encode_xdr!(optional_account_id)
    end

    test "decode_xdr/2", %{optional_account_id: optional_account_id, binary: binary} do
      {:ok, {^optional_account_id, ""}} = OptionalAccountID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalAccountID.decode_xdr(1234)
    end

    test "decode_xdr/2 when account_id is not opted" do
      {:ok, {%OptionalAccountID{account_id: nil}, ""}} =
        OptionalAccountID.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_account_id: optional_account_id, binary: binary} do
      {^optional_account_id, ^binary} = OptionalAccountID.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when account_id is not opted" do
      {%OptionalAccountID{account_id: nil}, ""} = OptionalAccountID.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
