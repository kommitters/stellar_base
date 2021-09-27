defmodule Stellar.XDR.Operations.AccountMergeTest do
  use ExUnit.Case

  alias Stellar.XDR.{CryptoKeyType, MuxedAccount, UInt256}

  alias Stellar.XDR.Operations.AccountMerge

  describe "AccountMerge Operation" do
    setup do
      muxed_account =
        "GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY"
        |> Stellar.Ed25519.PublicKey.decode!()
        |> UInt256.new()
        |> (&MuxedAccount.new(CryptoKeyType.new(:KEY_TYPE_ED25519), &1)).()

      account_merge = AccountMerge.new(muxed_account)

      %{
        account: muxed_account,
        account_merge: account_merge,
        binary:
          <<0, 0, 0, 0, 155, 142, 186, 248, 150, 56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16,
            107, 135, 171, 14, 45, 179, 214, 155, 117, 165, 56, 34, 114, 247, 89, 216>>
      }
    end

    test "new/1", %{account: muxed_account} do
      %AccountMerge{account: ^muxed_account} = AccountMerge.new(muxed_account)
    end

    test "encode_xdr/1", %{account_merge: account_merge, binary: binary} do
      {:ok, ^binary} = AccountMerge.encode_xdr(account_merge)
    end

    test "encode_xdr!/1", %{account_merge: account_merge, binary: binary} do
      ^binary = AccountMerge.encode_xdr!(account_merge)
    end

    test "decode_xdr/2", %{account_merge: account_merge, binary: binary} do
      {:ok, {^account_merge, ""}} = AccountMerge.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountMerge.decode_xdr(123)
    end

    test "decode_xdr!/2", %{account_merge: account_merge, binary: binary} do
      {^account_merge, ^binary} = AccountMerge.decode_xdr!(binary <> binary)
    end
  end
end
