defmodule StellarBase.XDR.ConfigSettingContractMetaDataV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingContractMetaDataV0, Int64, UInt32}

  setup do
    tx_max_extended_meta_data_size_bytes = UInt32.new(10)
    fee_extended_meta_data1_kb = Int64.new(10)

    config_setting_contract_meta_data =
      ConfigSettingContractMetaDataV0.new(
        tx_max_extended_meta_data_size_bytes,
        fee_extended_meta_data1_kb
      )

    %{
      tx_max_extended_meta_data_size_bytes: tx_max_extended_meta_data_size_bytes,
      fee_extended_meta_data1_kb: fee_extended_meta_data1_kb,
      config_setting_contract_meta_data: config_setting_contract_meta_data,
      binary: <<0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    tx_max_extended_meta_data_size_bytes: tx_max_extended_meta_data_size_bytes,
    fee_extended_meta_data1_kb: fee_extended_meta_data1_kb
  } do
    %ConfigSettingContractMetaDataV0{
      tx_max_extended_meta_data_size_bytes: ^tx_max_extended_meta_data_size_bytes,
      fee_extended_meta_data1_kb: ^fee_extended_meta_data1_kb
    } =
      ConfigSettingContractMetaDataV0.new(
        tx_max_extended_meta_data_size_bytes,
        fee_extended_meta_data1_kb
      )
  end

  test "encode_xdr/1", %{
    config_setting_contract_meta_data: config_setting_contract_meta_data,
    binary: binary
  } do
    {:ok, ^binary} = ConfigSettingContractMetaDataV0.encode_xdr(config_setting_contract_meta_data)
  end

  test "encode_xdr!/1", %{
    config_setting_contract_meta_data: config_setting_contract_meta_data,
    binary: binary
  } do
    ^binary = ConfigSettingContractMetaDataV0.encode_xdr!(config_setting_contract_meta_data)
  end

  test "decode_xdr/2", %{
    config_setting_contract_meta_data: config_setting_contract_meta_data,
    binary: binary
  } do
    {:ok, {^config_setting_contract_meta_data, ""}} =
      ConfigSettingContractMetaDataV0.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ConfigSettingContractMetaDataV0.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    config_setting_contract_meta_data: config_setting_contract_meta_data,
    binary: binary
  } do
    {^config_setting_contract_meta_data, ^binary} =
      ConfigSettingContractMetaDataV0.decode_xdr!(binary <> binary)
  end
end
