defmodule StellarBase.XDR.LedgerKeyDataTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, PublicKey, PublicKeyType, String64, Uint256}
  alias StellarBase.XDR.LedgerKeyData
  alias StellarBase.StrKey

  describe "Ledger LedgerKeyData" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> Uint256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      data_name = String64.new("Test")

      %{
        account_id: account_id,
        data_name: data_name,
        data: LedgerKeyData.new(account_id, data_name),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0,
            4, 84, 101, 115, 116>>
      }
    end

    test "new/1", %{account_id: account_id, data_name: data_name} do
      %LedgerKeyData{account_id: ^account_id, data_name: ^data_name} =
        LedgerKeyData.new(account_id, data_name)
    end

    test "encode_xdr/1", %{data: data, binary: binary} do
      {:ok, ^binary} = LedgerKeyData.encode_xdr(data)
    end

    test "encode_xdr!/1", %{data: data, binary: binary} do
      ^binary = LedgerKeyData.encode_xdr!(data)
    end

    test "decode_xdr/2", %{data: data, binary: binary} do
      {:ok, {^data, ""}} = LedgerKeyData.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyData.decode_xdr(123)
    end

    test "decode_xdr!/2", %{data: data, binary: binary} do
      {^data, ^binary} = LedgerKeyData.decode_xdr!(binary <> binary)
    end
  end
end
