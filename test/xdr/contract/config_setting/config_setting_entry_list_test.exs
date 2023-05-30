defmodule StellarBase.XDR.ConfigSettingEntryListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingEntry, ConfigSettingEntryList, ConfigSettingID, UInt32}

  describe "ConfigSettingEntryList" do
    setup do
      type = ConfigSettingID.new(:CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES)
      value1 = UInt32.new(0)
      value2 = UInt32.new(1)
      item1 = ConfigSettingEntry.new(value1, type)
      item2 = ConfigSettingEntry.new(value2, type)
      items = [item1, item2]
      config_setting_entry_list = ConfigSettingEntryList.new(items)

      %{
        items: items,
        config_setting_entry_list: config_setting_entry_list,
        binary: <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1>>
      }
    end

    test "new/1", %{items: items} do
      %ConfigSettingEntryList{items: ^items} = ConfigSettingEntryList.new(items)
    end

    test "encode_xdr/1", %{config_setting_entry_list: config_setting_entry_list, binary: binary} do
      {:ok, ^binary} = ConfigSettingEntryList.encode_xdr(config_setting_entry_list)
    end

    test "encode_xdr!/1", %{config_setting_entry_list: config_setting_entry_list, binary: binary} do
      ^binary = ConfigSettingEntryList.encode_xdr!(config_setting_entry_list)
    end

    test "decode_xdr/2", %{config_setting_entry_list: config_setting_entry_list, binary: binary} do
      {:ok, {^config_setting_entry_list, ""}} = ConfigSettingEntryList.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ConfigSettingEntryList.decode_xdr(123)
    end

    test "decode_xdr!/2", %{config_setting_entry_list: config_setting_entry_list, binary: binary} do
      {^config_setting_entry_list, ^binary} = ConfigSettingEntryList.decode_xdr!(binary <> binary)
    end
  end
end
