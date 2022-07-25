defmodule StellarBase.XDR.AccountEntryExtensionV1ExtTest do
  use ExUnit.Case

  import StellarBase.Test.Utils

  alias StellarBase.XDR.{
    AccountEntryExtensionV2,
    AccountEntryExtensionV1Ext,
    AccountIDList,
    Ext,
    UInt32,
    Void
  }

  @types [0, 2]

  describe "AccountEntryExtensionV1Ext" do
    setup do
      account_entry_extension_v1_ext_list =
        [
          %{type: 0, value: Void.new()},
          %{
            type: 2,
            value:
              AccountEntryExtensionV2.new(
                UInt32.new(10),
                UInt32.new(10),
                create_account_id_list(),
                Ext.new()
              )
          }
        ]
        |> Enum.map(fn %{type: type, value: value} ->
          AccountEntryExtensionV1Ext.new(value, type)
        end)

      %{
        types: @types,
        values: account_entry_extension_v1_ext_list,
        binaries: [
          <<0, 0, 0, 0>>,
          <<0, 0, 0, 2, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 2, 0, 0, 0, 0, 155, 142, 186, 248, 150,
            56, 85, 29, 207, 158, 164, 247, 67, 32, 113, 16, 107, 135, 171, 14, 45, 179, 214, 155,
            117, 165, 56, 34, 114, 247, 89, 216, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154,
            137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212,
            179, 73, 138, 2, 227, 119, 0, 0, 0, 0>>
        ]
      }
    end

    test "new/1", %{types: types, values: values} do
      for {value, type} <- Enum.zip(values, types),
          do:
            %AccountEntryExtensionV1Ext{value: ^value, type: ^type} =
              AccountEntryExtensionV1Ext.new(value, type)
    end

    test "encode_xdr/1", %{
      values: account_entry_extension_v1_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v1, binary} <-
            Enum.zip(account_entry_extension_v1_ext_list, binaries),
          do: {:ok, ^binary} = AccountEntryExtensionV1Ext.encode_xdr(account_entry_extension_v1)
    end

    test "encode_xdr!/1", %{
      values: account_entry_extension_v1_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v1, binary} <-
            Enum.zip(account_entry_extension_v1_ext_list, binaries),
          do: ^binary = AccountEntryExtensionV1Ext.encode_xdr!(account_entry_extension_v1)
    end

    test "decode_xdr/1", %{
      values: account_entry_extension_v1_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v1_ext, binary} <-
            Enum.zip(account_entry_extension_v1_ext_list, binaries),
          do:
            {:ok, {^account_entry_extension_v1_ext, ""}} =
              AccountEntryExtensionV1Ext.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{
      values: account_entry_extension_v1_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v1_ext, binary} <-
            Enum.zip(account_entry_extension_v1_ext_list, binaries),
          do:
            {^account_entry_extension_v1_ext, ""} = AccountEntryExtensionV1Ext.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountEntryExtensionV1Ext.decode_xdr(123)
    end
  end

  @spec create_account_id_list() :: AccountIDList.t()
  defp create_account_id_list do
    account_id_1 = create_account_id("GCNY5OXYSY4FKHOPT2SPOQZAOEIGXB5LBYW3HVU3OWSTQITS65M5RCNY")
    account_id_2 = create_account_id("GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD")

    [account_id_1, account_id_2]
    |> AccountIDList.new()
  end
end
