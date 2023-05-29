defmodule StellarBase.XDR.ConfigSettingContractLedgerCostV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingContractLedgerCostV0, UInt32, Int64}

  setup do
    ledger_max_read_ledger_entries = UInt32.new(10)
    ledger_max_read_bytes = UInt32.new(10)
    ledger_max_write_ledger_entries = UInt32.new(10)
    ledger_max_write_bytes = UInt32.new(10)
    tx_max_read_ledger_entries = UInt32.new(10)
    tx_max_read_bytes = UInt32.new(10)
    tx_max_write_ledger_entries = UInt32.new(10)
    tx_max_write_bytes = UInt32.new(10)
    fee_read_ledger_entry = Int64.new(10)
    fee_write_ledger_entry = Int64.new(10)
    fee_read1_kb = Int64.new(10)
    fee_write1_kb = Int64.new(10)
    bucket_list_size_bytes = Int64.new(10)
    bucket_list_fee_rate_low = Int64.new(10)
    bucket_list_fee_rate_high = Int64.new(10)
    bucket_list_growth_factor = UInt32.new(10)

    config_setting_contract_ledger_cost_v0 =
      ConfigSettingContractLedgerCostV0.new(
        ledger_max_read_ledger_entries,
        ledger_max_read_bytes,
        ledger_max_write_ledger_entries,
        ledger_max_write_bytes,
        tx_max_read_ledger_entries,
        tx_max_read_bytes,
        tx_max_write_ledger_entries,
        tx_max_write_bytes,
        fee_read_ledger_entry,
        fee_write_ledger_entry,
        fee_read1_kb,
        fee_write1_kb,
        bucket_list_size_bytes,
        bucket_list_fee_rate_low,
        bucket_list_fee_rate_high,
        bucket_list_growth_factor
      )

    %{
      ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
      ledger_max_read_bytes: ledger_max_read_bytes,
      ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
      ledger_max_write_bytes: ledger_max_write_bytes,
      tx_max_read_ledger_entries: tx_max_read_ledger_entries,
      tx_max_read_bytes: tx_max_read_bytes,
      tx_max_write_ledger_entries: tx_max_write_ledger_entries,
      tx_max_write_bytes: tx_max_write_bytes,
      fee_read_ledger_entry: fee_read_ledger_entry,
      fee_write_ledger_entry: fee_write_ledger_entry,
      fee_read1_kb: fee_read1_kb,
      fee_write1_kb: fee_write1_kb,
      bucket_list_size_bytes: bucket_list_size_bytes,
      bucket_list_fee_rate_low: bucket_list_fee_rate_low,
      bucket_list_fee_rate_high: bucket_list_fee_rate_high,
      bucket_list_growth_factor: bucket_list_growth_factor,
      config_setting_contract_ledger_cost_v0: config_setting_contract_ledger_cost_v0,
      binary:
        <<0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0,
          10, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0,
          10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0,
          0, 0, 0, 0, 10, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
    ledger_max_read_bytes: ledger_max_read_bytes,
    ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
    ledger_max_write_bytes: ledger_max_write_bytes,
    tx_max_read_ledger_entries: tx_max_read_ledger_entries,
    tx_max_read_bytes: tx_max_read_bytes,
    tx_max_write_ledger_entries: tx_max_write_ledger_entries,
    tx_max_write_bytes: tx_max_write_bytes,
    fee_read_ledger_entry: fee_read_ledger_entry,
    fee_write_ledger_entry: fee_write_ledger_entry,
    fee_read1_kb: fee_read1_kb,
    fee_write1_kb: fee_write1_kb,
    bucket_list_size_bytes: bucket_list_size_bytes,
    bucket_list_fee_rate_low: bucket_list_fee_rate_low,
    bucket_list_fee_rate_high: bucket_list_fee_rate_high,
    bucket_list_growth_factor: bucket_list_growth_factor
  } do
    %ConfigSettingContractLedgerCostV0{
      ledger_max_read_ledger_entries: ^ledger_max_read_ledger_entries,
      ledger_max_read_bytes: ^ledger_max_read_bytes,
      ledger_max_write_ledger_entries: ^ledger_max_write_ledger_entries,
      ledger_max_write_bytes: ^ledger_max_write_bytes,
      tx_max_read_ledger_entries: ^tx_max_read_ledger_entries,
      tx_max_read_bytes: ^tx_max_read_bytes,
      tx_max_write_ledger_entries: ^tx_max_write_ledger_entries,
      tx_max_write_bytes: ^tx_max_write_bytes,
      fee_read_ledger_entry: ^fee_read_ledger_entry,
      fee_write_ledger_entry: ^fee_write_ledger_entry,
      fee_read1_kb: ^fee_read1_kb,
      fee_write1_kb: ^fee_write1_kb,
      bucket_list_size_bytes: ^bucket_list_size_bytes,
      bucket_list_fee_rate_low: ^bucket_list_fee_rate_low,
      bucket_list_fee_rate_high: ^bucket_list_fee_rate_high,
      bucket_list_growth_factor: ^bucket_list_growth_factor
    } =
      ConfigSettingContractLedgerCostV0.new(
        ledger_max_read_ledger_entries,
        ledger_max_read_bytes,
        ledger_max_write_ledger_entries,
        ledger_max_write_bytes,
        tx_max_read_ledger_entries,
        tx_max_read_bytes,
        tx_max_write_ledger_entries,
        tx_max_write_bytes,
        fee_read_ledger_entry,
        fee_write_ledger_entry,
        fee_read1_kb,
        fee_write1_kb,
        bucket_list_size_bytes,
        bucket_list_fee_rate_low,
        bucket_list_fee_rate_high,
        bucket_list_growth_factor
      )
  end

  test "encode_xdr/1", %{
    config_setting_contract_ledger_cost_v0: config_setting_contract_ledger_cost_v0,
    binary: binary
  } do
    {:ok, ^binary} =
      ConfigSettingContractLedgerCostV0.encode_xdr(config_setting_contract_ledger_cost_v0)
  end

  test "encode_xdr!/1", %{
    config_setting_contract_ledger_cost_v0: config_setting_contract_ledger_cost_v0,
    binary: binary
  } do
    ^binary = ConfigSettingContractLedgerCostV0.encode_xdr!(config_setting_contract_ledger_cost_v0)
  end

  test "decode_xdr/2", %{
    config_setting_contract_ledger_cost_v0: config_setting_contract_ledger_cost_v0,
    binary: binary
  } do
    {:ok, {^config_setting_contract_ledger_cost_v0, ""}} =
      ConfigSettingContractLedgerCostV0.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ConfigSettingContractLedgerCostV0.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    config_setting_contract_ledger_cost_v0: config_setting_contract_ledger_cost_v0,
    binary: binary
  } do
    {^config_setting_contract_ledger_cost_v0, ^binary} =
      ConfigSettingContractLedgerCostV0.decode_xdr!(binary <> binary)
  end
end
