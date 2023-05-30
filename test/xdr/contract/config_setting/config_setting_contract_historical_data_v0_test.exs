defmodule StellarBase.XDR.ConfigSettingContractHistoricalDataV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingContractHistoricalDataV0, Int64}

  setup do
    fee_historical1_kb = Int64.new(10)

    config_setting_contract_historical_data =
      ConfigSettingContractHistoricalDataV0.new(fee_historical1_kb)

    %{
      fee_historical1_kb: fee_historical1_kb,
      config_setting_contract_historical_data: config_setting_contract_historical_data,
      binary: <<0, 0, 0, 0, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    fee_historical1_kb: fee_historical1_kb
  } do
    %ConfigSettingContractHistoricalDataV0{
      fee_historical1_kb: ^fee_historical1_kb
    } = ConfigSettingContractHistoricalDataV0.new(fee_historical1_kb)
  end

  test "encode_xdr/1", %{
    config_setting_contract_historical_data: config_setting_contract_historical_data,
    binary: binary
  } do
    {:ok, ^binary} =
      ConfigSettingContractHistoricalDataV0.encode_xdr(config_setting_contract_historical_data)
  end

  test "encode_xdr!/1", %{
    config_setting_contract_historical_data: config_setting_contract_historical_data,
    binary: binary
  } do
    ^binary =
      ConfigSettingContractHistoricalDataV0.encode_xdr!(config_setting_contract_historical_data)
  end

  test "decode_xdr/2", %{
    config_setting_contract_historical_data: config_setting_contract_historical_data,
    binary: binary
  } do
    {:ok, {^config_setting_contract_historical_data, ""}} =
      ConfigSettingContractHistoricalDataV0.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ConfigSettingContractHistoricalDataV0.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    config_setting_contract_historical_data: config_setting_contract_historical_data,
    binary: binary
  } do
    {^config_setting_contract_historical_data, ^binary} =
      ConfigSettingContractHistoricalDataV0.decode_xdr!(binary <> binary)
  end
end
