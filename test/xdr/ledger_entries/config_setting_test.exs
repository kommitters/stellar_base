defmodule StellarBase.XDR.ConfigSettingTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSetting, ConfigSettingType, Uint32}

  describe "ConfigSetting" do
    setup do
      value = Uint32.new(4_545_234)
      type = ConfigSettingType.new(:CONFIG_SETTING_TYPE_UINT32)

      %{
        value: value,
        type: type,
        config_setting: ConfigSetting.new(value, type),
        binary: <<0, 0, 0, 0, 0, 69, 90, 210>>
      }
    end

    test "new/1", %{value: value, type: type} do
      %ConfigSetting{value: ^value, type: ^type} = ConfigSetting.new(value, type)
    end

    test "encode_xdr/1", %{config_setting: config_setting, binary: binary} do
      {:ok, ^binary} = ConfigSetting.encode_xdr(config_setting)
    end

    test "encode_xdr/1 with an invalid type", %{value: value} do
      type = ConfigSettingType.new(:NEW_CONTRACT)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     value
                     |> ConfigSetting.new(type)
                     |> ConfigSetting.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{config_setting: config_setting, binary: binary} do
      ^binary = ConfigSetting.encode_xdr!(config_setting)
    end

    test "decode_xdr/2", %{config_setting: config_setting, binary: binary} do
      {:ok, {^config_setting, ""}} = ConfigSetting.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ConfigSetting.decode_xdr(123)
    end

    test "decode_xdr!/2", %{config_setting: config_setting, binary: binary} do
      {^config_setting, ^binary} = ConfigSetting.decode_xdr!(binary <> binary)
    end
  end
end
