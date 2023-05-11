defmodule StellarBase.XDR.AccountIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, PublicKey, PublicKeyType, Uint256}

  describe "StellarBase.XDR.AccountID" do
    setup do
      public_key = %PublicKey{
        value: %Uint256{
          value:
            <<18, 27, 249, 51, 160, 215, 152, 50, 153, 222, 53, 177, 115, 224, 92, 243, 51, 242,
              249, 40, 118, 78, 128, 109, 86, 239, 171, 232, 42, 171, 210, 35>>
        },
        type: %PublicKeyType{
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

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{account_id: account_id, encoded_binary: binary} do
      {^account_id, ^binary} = AccountID.decode_xdr!(binary <> binary)
    end

    test "invalid PublicKey" do
      assert_raise FunctionClauseError,
                   "no function clause matching in StellarBase.XDR.AccountID.new/1",
                   fn ->
                     "SFDCVXGSGSG"
                     |> Uint256.new()
                     |> AccountID.new()
                   end
    end
  end
end
