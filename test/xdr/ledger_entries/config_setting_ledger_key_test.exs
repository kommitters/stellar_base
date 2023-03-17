defmodule StellarBase.XDR.ConfigSettingLedgerKeyTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ConfigSettingLedgerKey,
    ConfigSettingID
  }

  describe "ConfigSettingLedgerKey" do
    setup do
      config_setting_id = ConfigSettingID.new(:CONFIG_SETTING_CONTRACT_MAX_SIZE)

      %{
        config_setting_id: config_setting_id,
        config_setting_ledger_key: ConfigSettingLedgerKey.new(config_setting_id),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{config_setting_id: config_setting_id} do
      %ConfigSettingLedgerKey{config_setting_id: ^config_setting_id} =
        ConfigSettingLedgerKey.new(config_setting_id)
    end

    test "encode_xdr/1", %{config_setting_ledger_key: config_setting_ledger_key, binary: binary} do
      {:ok, ^binary} = ConfigSettingLedgerKey.encode_xdr(config_setting_ledger_key)
    end

    test "encode_xdr!/1", %{
      config_setting_ledger_key: config_setting_ledger_key,
      binary: binary
    } do
      ^binary = ConfigSettingLedgerKey.encode_xdr!(config_setting_ledger_key)
    end

    test "decode_xdr/2", %{config_setting_ledger_key: config_setting_ledger_key, binary: binary} do
      {:ok, {^config_setting_ledger_key, ""}} = ConfigSettingLedgerKey.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ConfigSettingLedgerKey.decode_xdr(123)
    end

    test "decode_xdr!/2", %{
      config_setting_ledger_key: config_setting_ledger_key,
      binary: binary
    } do
      {^config_setting_ledger_key, ^binary} = ConfigSettingLedgerKey.decode_xdr!(binary <> binary)
    end
  end
end
