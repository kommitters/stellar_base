defmodule StellarBase.XDR.ConfigSettingContractBandwidthV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingContractBandwidthV0, UInt32, Int64}

  setup do
    ledger_max_txs_size_bytes = UInt32.new(10)
    tx_max_size_bytes = UInt32.new(10)
    fee_tx_size1_kb = Int64.new(10)

    config_setting_contract_bandwidth_v0 =
      ConfigSettingContractBandwidthV0.new(
        ledger_max_txs_size_bytes,
        tx_max_size_bytes,
        fee_tx_size1_kb
      )

    %{
      ledger_max_txs_size_bytes: ledger_max_txs_size_bytes,
      tx_max_size_bytes: tx_max_size_bytes,
      fee_tx_size1_kb: fee_tx_size1_kb,
      config_setting_contract_bandwidth_v0: config_setting_contract_bandwidth_v0,
      binary: <<0, 0, 0, 10, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    ledger_max_txs_size_bytes: ledger_max_txs_size_bytes,
    tx_max_size_bytes: tx_max_size_bytes,
    fee_tx_size1_kb: fee_tx_size1_kb
  } do
    %ConfigSettingContractBandwidthV0{
      ledger_max_txs_size_bytes: ^ledger_max_txs_size_bytes,
      tx_max_size_bytes: ^tx_max_size_bytes,
      fee_tx_size1_kb: ^fee_tx_size1_kb
    } =
      ConfigSettingContractBandwidthV0.new(
        ledger_max_txs_size_bytes,
        tx_max_size_bytes,
        fee_tx_size1_kb
      )
  end

  test "encode_xdr/1", %{
    config_setting_contract_bandwidth_v0: config_setting_contract_bandwidth_v0,
    binary: binary
  } do
    {:ok, ^binary} =
      ConfigSettingContractBandwidthV0.encode_xdr(config_setting_contract_bandwidth_v0)
  end

  test "encode_xdr!/1", %{
    config_setting_contract_bandwidth_v0: config_setting_contract_bandwidth_v0,
    binary: binary
  } do
    ^binary = ConfigSettingContractBandwidthV0.encode_xdr!(config_setting_contract_bandwidth_v0)
  end

  test "decode_xdr/2", %{
    config_setting_contract_bandwidth_v0: config_setting_contract_bandwidth_v0,
    binary: binary
  } do
    {:ok, {^config_setting_contract_bandwidth_v0, ""}} =
      ConfigSettingContractBandwidthV0.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ConfigSettingContractBandwidthV0.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    config_setting_contract_bandwidth_v0: config_setting_contract_bandwidth_v0,
    binary: binary
  } do
    {^config_setting_contract_bandwidth_v0, ^binary} =
      ConfigSettingContractBandwidthV0.decode_xdr!(binary <> binary)
  end
end
