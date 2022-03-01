defmodule StellarBase.XDR.DataEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    PublicKey,
    PublicKeyType,
    String64,
    UInt256,
    DataValue,
    Ext,
    DataEntry
  }

  alias StellarBase.StrKey

  describe "DataEntryTest" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      account_id =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      data_name = String64.new("Test")

      data_value = DataValue.new("GCIZ3GSM5")

      ext = Ext.new()

      %{
        account_id: account_id,
        data_name: data_name,
        data_value: data_value,
        ext: ext,
        data_entry: DataEntry.new(account_id, data_name, data_value, ext),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0,
            4, 84, 101, 115, 116, 0, 0, 0, 9, 71, 67, 73, 90, 51, 71, 83, 77, 53, 0, 0, 0, 0, 0,
            0, 0>>
      }
    end

    test "new/1", %{
      account_id: account_id,
      data_name: data_name,
      data_value: data_value,
      ext: ext
    } do
      %DataEntry{
        account_id: ^account_id,
        data_name: ^data_name,
        data_value: ^data_value,
        ext: ^ext
      } = DataEntry.new(account_id, data_name, data_value, ext)
    end

    test "encode_xdr/1", %{data_entry: data_entry, binary: binary} do
      {:ok, ^binary} = DataEntry.encode_xdr(data_entry)
    end

    test "encode_xdr!/1", %{data_entry: data_entry, binary: binary} do
      ^binary = DataEntry.encode_xdr!(data_entry)
    end

    test "decode_xdr/2", %{data_entry: data_entry, binary: binary} do
      {:ok, {^data_entry, ""}} = DataEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = DataEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{data_entry: data_entry, binary: binary} do
      {^data_entry, ^binary} = DataEntry.decode_xdr!(binary <> binary)
    end
  end
end
