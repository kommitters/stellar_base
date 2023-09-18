defmodule StellarBase.XDR.ConfigSettingContractEventsV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingContractEventsV0, UInt32, Int64}

  setup do
    tx_max_contract_events_size_bytes = UInt32.new(10)
    fee_contract_events1_kb = Int64.new(10)

    config_setting_contract_events =
      ConfigSettingContractEventsV0.new(
        tx_max_contract_events_size_bytes,
        fee_contract_events1_kb
      )

    %{
      tx_max_contract_events_size_bytes: tx_max_contract_events_size_bytes,
      fee_contract_events1_kb: fee_contract_events1_kb,
      config_setting_contract_events: config_setting_contract_events,
      binary: <<0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    tx_max_contract_events_size_bytes: tx_max_contract_events_size_bytes,
    fee_contract_events1_kb: fee_contract_events1_kb
  } do
    %ConfigSettingContractEventsV0{
      tx_max_contract_events_size_bytes: ^tx_max_contract_events_size_bytes,
      fee_contract_events1_kb: ^fee_contract_events1_kb
    } =
      ConfigSettingContractEventsV0.new(
        tx_max_contract_events_size_bytes,
        fee_contract_events1_kb
      )
  end

  test "encode_xdr/1", %{
    config_setting_contract_events: config_setting_contract_events,
    binary: binary
  } do
    {:ok, ^binary} = ConfigSettingContractEventsV0.encode_xdr(config_setting_contract_events)
  end

  test "encode_xdr!/1", %{
    config_setting_contract_events: config_setting_contract_events,
    binary: binary
  } do
    ^binary = ConfigSettingContractEventsV0.encode_xdr!(config_setting_contract_events)
  end

  test "decode_xdr/2", %{
    config_setting_contract_events: config_setting_contract_events,
    binary: binary
  } do
    {:ok, {^config_setting_contract_events, ""}} =
      ConfigSettingContractEventsV0.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ConfigSettingContractEventsV0.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    config_setting_contract_events: config_setting_contract_events,
    binary: binary
  } do
    {^config_setting_contract_events, ^binary} =
      ConfigSettingContractEventsV0.decode_xdr!(binary <> binary)
  end
end
