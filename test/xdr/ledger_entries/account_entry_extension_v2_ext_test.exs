defmodule StellarBase.XDR.AccountEntryExtensionV2ExtTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountEntryExtensionV2Ext,
    AccountEntryExtensionV3,
    ExtensionPoint,
    TimePoint,
    Uint32,
    Uint64,
    Void
  }

  describe "AccountEntryExtensionV2Ext" do
    setup do
      extension_point = ExtensionPoint.new(Void.new(), 0)
      seq_ledger = Uint32.new(10)
      seq_time = TimePoint.new(Uint64.new(12_345))

      account_entry_extension_v2_ext_list =
        [
          %{type: 0, value: Void.new()},
          %{
            type: 3,
            value: AccountEntryExtensionV3.new(extension_point, seq_ledger, seq_time)
          }
        ]
        |> Enum.map(fn %{type: type, value: value} ->
          AccountEntryExtensionV2Ext.new(value, type)
        end)

      %{
        types: [0, 3],
        values: account_entry_extension_v2_ext_list,
        binaries: [
          <<0, 0, 0, 0>>,
          <<0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 48, 57>>
        ]
      }
    end

    test "new/1", %{types: types, values: values} do
      for {value, type} <- Enum.zip(values, types),
          do:
            %AccountEntryExtensionV2Ext{value: ^value, type: ^type} =
              AccountEntryExtensionV2Ext.new(value, type)
    end

    test "encode_xdr/1", %{
      values: account_entry_extension_v2_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(account_entry_extension_v2_ext_list, binaries),
          do:
            {:ok, ^binary} = AccountEntryExtensionV2Ext.encode_xdr(account_entry_extension_v2_ext)
    end

    test "encode_xdr!/1", %{
      values: account_entry_extension_v2_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(account_entry_extension_v2_ext_list, binaries),
          do: ^binary = AccountEntryExtensionV2Ext.encode_xdr!(account_entry_extension_v2_ext)
    end

    test "decode_xdr/1", %{
      values: account_entry_extension_v2_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(account_entry_extension_v2_ext_list, binaries),
          do:
            {:ok, {^account_entry_extension_v2_ext, ""}} =
              AccountEntryExtensionV2Ext.decode_xdr(binary)
    end

    test "decode_xdr!/1", %{
      values: account_entry_extension_v2_ext_list,
      binaries: binaries
    } do
      for {account_entry_extension_v2_ext, binary} <-
            Enum.zip(account_entry_extension_v2_ext_list, binaries),
          do:
            {^account_entry_extension_v2_ext, ""} = AccountEntryExtensionV2Ext.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountEntryExtensionV2Ext.decode_xdr(123)
    end
  end
end
