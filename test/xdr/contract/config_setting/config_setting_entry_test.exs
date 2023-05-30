defmodule StellarBase.XDR.ConfigSettingTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingEntry, ConfigSettingID, UInt32}

  describe "ConfigSetting" do
    setup do
      value = UInt32.new(4_545_234)
      type = ConfigSettingID.new(:CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES)

      %{
        value: value,
        type: type,
        config_setting_entry: ConfigSettingEntry.new(value, type),
        binary: <<0, 0, 0, 0, 0, 69, 90, 210>>
      }
    end

    test "new/1", %{value: value, type: type} do
      %ConfigSettingEntry{value: ^value, type: ^type} = ConfigSettingEntry.new(value, type)
    end

    test "encode_xdr/1", %{config_setting_entry: config_setting_entry, binary: binary} do
      {:ok, ^binary} = ConfigSettingEntry.encode_xdr(config_setting_entry)
    end

    test "encode_xdr/1 with an invalid type", %{value: value} do
      type = ConfigSettingID.new(:NEW_CONTRACT)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     value
                     |> ConfigSettingEntry.new(type)
                     |> ConfigSettingEntry.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{config_setting_entry: config_setting_entry, binary: binary} do
      ^binary = ConfigSettingEntry.encode_xdr!(config_setting_entry)
    end

    test "decode_xdr/2", %{config_setting_entry: config_setting_entry, binary: binary} do
      {:ok, {^config_setting_entry, ""}} = ConfigSettingEntry.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ConfigSettingEntry.decode_xdr(123)
    end

    test "decode_xdr!/2", %{config_setting_entry: config_setting_entry, binary: binary} do
      {^config_setting_entry, ^binary} = ConfigSettingEntry.decode_xdr!(binary <> binary)
    end
  end
end
