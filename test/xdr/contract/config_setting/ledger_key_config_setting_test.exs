defmodule StellarBase.XDR.LedgerKeyConfigSettingTest do
  use ExUnit.Case

  alias StellarBase.XDR.{LedgerKeyConfigSetting, ConfigSettingID}

  describe "LedgerKeyConfigSetting" do
    setup do
      config_setting_id = ConfigSettingID.new(:CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES)

      %{
        config_setting_id: config_setting_id,
        config_setting_ledger_key: LedgerKeyConfigSetting.new(config_setting_id),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{config_setting_id: config_setting_id} do
      %LedgerKeyConfigSetting{config_setting_id: ^config_setting_id} =
        LedgerKeyConfigSetting.new(config_setting_id)
    end

    test "encode_xdr/1", %{config_setting_ledger_key: config_setting_ledger_key, binary: binary} do
      {:ok, ^binary} = LedgerKeyConfigSetting.encode_xdr(config_setting_ledger_key)
    end

    test "encode_xdr!/1", %{
      config_setting_ledger_key: config_setting_ledger_key,
      binary: binary
    } do
      ^binary = LedgerKeyConfigSetting.encode_xdr!(config_setting_ledger_key)
    end

    test "decode_xdr/2", %{config_setting_ledger_key: config_setting_ledger_key, binary: binary} do
      {:ok, {^config_setting_ledger_key, ""}} = LedgerKeyConfigSetting.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerKeyConfigSetting.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      config_setting_ledger_key: config_setting_ledger_key,
      binary: binary
    } do
      {^config_setting_ledger_key, ^binary} = LedgerKeyConfigSetting.decode_xdr!(binary <> binary)
    end
  end
end
