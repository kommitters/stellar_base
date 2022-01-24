defmodule StellarBase.XDR.DataTest do
  use ExUnit.Case

  alias StellarBase.XDR.{AccountID, PublicKey, PublicKeyType, String64, UInt256}
  alias StellarBase.XDR.Data
  alias StellarBase.StrKey

  describe "Ledger Data" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      data_name = String64.new("Test")

      %{
        account_id: account_id,
        data_name: data_name,
        data: Data.new(account_id, data_name),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0,
            4, 84, 101, 115, 116>>
      }
    end

    test "new/1", %{account_id: account_id, data_name: data_name} do
      %Data{account_id: ^account_id, data_name: ^data_name} = Data.new(account_id, data_name)
    end

    test "encode_xdr/1", %{data: data, binary: binary} do
      {:ok, ^binary} = Data.encode_xdr(data)
    end

    test "encode_xdr!/1", %{data: data, binary: binary} do
      ^binary = Data.encode_xdr!(data)
    end

    test "decode_xdr/2", %{data: data, binary: binary} do
      {:ok, {^data, ""}} = Data.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Data.decode_xdr(123)
    end

    test "decode_xdr!/2", %{data: data, binary: binary} do
      {^data, ^binary} = Data.decode_xdr!(binary <> binary)
    end
  end
end
