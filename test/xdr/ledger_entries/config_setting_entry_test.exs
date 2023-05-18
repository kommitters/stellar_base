defmodule StellarBase.XDR.ConfigSettingEntryTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ConfigSettingEntry,
    ConfigSettingType,
    ConfigSettingID,
    ConfigSetting,
    ConfigSettingEntryExt,
    Uint32,
    Void
  }

  describe "ConfigSettingEntry" do
    setup do
      extension_point = ConfigSettingEntryExt.new(Void.new(), 0)
      value = Uint32.new(4_545_234)
      type = ConfigSettingType.new(:CONFIG_SETTING_TYPE_UINT32)

      config_setting_id = ConfigSettingID.new(:CONFIG_SETTING_CONTRACT_MAX_SIZE)
      config_setting = ConfigSetting.new(value, type)

      %{
        ext: extension_point,
        config_setting_id: config_setting_id,
        config_setting: config_setting,
        config_setting_entry:
          ConfigSettingEntry.new(extension_point, config_setting_id, config_setting),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 69, 90, 210, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{
      ext: extension_point,
      config_setting_id: config_setting_id,
      config_setting: config_setting
    } do
      %ConfigSettingEntry{
        config_setting_id: ^config_setting_id,
        setting: ^config_setting,
        ext: ^extension_point
      } = ConfigSettingEntry.new(extension_point, config_setting_id, config_setting)
    end

    test "encode_xdr/1", %{config_setting_entry: config_setting_entry, binary: binary} do
      {:ok, ^binary} = ConfigSettingEntry.encode_xdr(config_setting_entry)
    end

    test "encode_xdr!/1", %{
      config_setting_entry: config_setting_entry,
      binary: binary
    } do
      ^binary = ConfigSettingEntry.encode_xdr!(config_setting_entry)
    end

    test "decode_xdr/2", %{config_setting_entry: config_setting_entry, binary: binary} do
      {:ok, {^config_setting_entry, ""}} = ConfigSettingEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ConfigSettingEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      config_setting_entry: config_setting_entry,
      binary: binary
    } do
      {^config_setting_entry, ^binary} = ConfigSettingEntry.decode_xdr!(binary <> binary)
    end
  end
end
