defmodule Stellar.XDR.AccountIDTest do
  use ExUnit.Case

  alias Stellar.XDR.{AccountID, PublicKey, PublicKeyType, UInt256}

  describe "Stellar.XDR.AccountID" do
    setup do
      public_key = %PublicKey{
        public_key: %UInt256{
          datum:
            <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
              249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        },
        type: %PublicKeyType{
          declarations: [PUBLIC_KEY_TYPE_ED25519: 0],
          identifier: :PUBLIC_KEY_TYPE_ED25519
        }
      }

      %{
        public_key: public_key,
        account_id: AccountID.new(public_key),
        encoded_binary:
          <<0, 0, 0, 0, 18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243,
            51, 242, 249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
      }
    end

    test "new/1", %{public_key: public_key} do
      %AccountID{account_id: ^public_key} = AccountID.new(public_key)
    end

    test "encode_xdr/1", %{account_id: account_id, encoded_binary: binary} do
      {:ok, ^binary} = AccountID.encode_xdr(account_id)
    end

    test "encode_xdr!/1", %{account_id: account_id, encoded_binary: binary} do
      ^binary = AccountID.encode_xdr!(account_id)
    end

    test "decode_xdr/2", %{account_id: account_id, encoded_binary: binary} do
      {:ok, {^account_id, ""}} = AccountID.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{account_id: account_id, encoded_binary: binary} do
      {^account_id, ^binary} = AccountID.decode_xdr!(binary <> binary)
    end

    test "invalid PublicKey" do
      assert_raise FunctionClauseError,
                   "no function clause matching in Stellar.XDR.AccountID.new/1",
                   fn ->
                     "SFDCVXGSGSG"
                     |> UInt256.new()
                     |> AccountID.new()
                   end
    end
  end
end
