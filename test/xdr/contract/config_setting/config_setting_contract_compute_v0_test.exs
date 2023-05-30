defmodule StellarBase.XDR.ConfigSettingContractComputeV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingContractComputeV0, UInt32, Int64}

  setup do
    ledger_max_instructions = Int64.new(10)
    tx_max_instructions = Int64.new(10)
    fee_rate_per_instructions_increment = Int64.new(10)
    tx_memory_limit = UInt32.new(10)

    config_setting_contract_compute =
      ConfigSettingContractComputeV0.new(
        ledger_max_instructions,
        tx_max_instructions,
        fee_rate_per_instructions_increment,
        tx_memory_limit
      )

    %{
      ledger_max_instructions: ledger_max_instructions,
      tx_max_instructions: tx_max_instructions,
      fee_rate_per_instructions_increment: fee_rate_per_instructions_increment,
      tx_memory_limit: tx_memory_limit,
      config_setting_contract_compute: config_setting_contract_compute,
      binary:
        <<0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    ledger_max_instructions: ledger_max_instructions,
    tx_max_instructions: tx_max_instructions,
    fee_rate_per_instructions_increment: fee_rate_per_instructions_increment,
    tx_memory_limit: tx_memory_limit
  } do
    %ConfigSettingContractComputeV0{
      ledger_max_instructions: ^ledger_max_instructions,
      tx_max_instructions: ^tx_max_instructions,
      fee_rate_per_instructions_increment: ^fee_rate_per_instructions_increment,
      tx_memory_limit: ^tx_memory_limit
    } =
      ConfigSettingContractComputeV0.new(
        ledger_max_instructions,
        tx_max_instructions,
        fee_rate_per_instructions_increment,
        tx_memory_limit
      )
  end

  test "encode_xdr/1", %{
    config_setting_contract_compute: config_setting_contract_compute,
    binary: binary
  } do
    {:ok, ^binary} = ConfigSettingContractComputeV0.encode_xdr(config_setting_contract_compute)
  end

  test "encode_xdr!/1", %{
    config_setting_contract_compute: config_setting_contract_compute,
    binary: binary
  } do
    ^binary = ConfigSettingContractComputeV0.encode_xdr!(config_setting_contract_compute)
  end

  test "decode_xdr/2", %{
    config_setting_contract_compute: config_setting_contract_compute,
    binary: binary
  } do
    {:ok, {^config_setting_contract_compute, ""}} =
      ConfigSettingContractComputeV0.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ConfigSettingContractComputeV0.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    config_setting_contract_compute: config_setting_contract_compute,
    binary: binary
  } do
    {^config_setting_contract_compute, ^binary} =
      ConfigSettingContractComputeV0.decode_xdr!(binary <> binary)
  end
end
