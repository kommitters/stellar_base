defmodule StellarBase.XDR.ConfigSettingIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.ConfigSettingID

  @codes [
    :CONFIG_SETTING_CONTRACT_MAX_SIZE_BYTES,
    :CONFIG_SETTING_CONTRACT_COMPUTE_V0,
    :CONFIG_SETTING_CONTRACT_LEDGER_COST_V0,
    :CONFIG_SETTING_CONTRACT_HISTORICAL_DATA_V0,
    :CONFIG_SETTING_CONTRACT_META_DATA_V0,
    :CONFIG_SETTING_CONTRACT_BANDWIDTH_V0,
    :CONFIG_SETTING_CONTRACT_COST_PARAMS_CPU_INSTRUCTIONS,
    :CONFIG_SETTING_CONTRACT_COST_PARAMS_MEMORY_BYTES,
    :CONFIG_SETTING_CONTRACT_DATA_KEY_SIZE_BYTES,
    :CONFIG_SETTING_CONTRACT_DATA_ENTRY_SIZE_BYTES
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 3>>,
    <<0, 0, 0, 4>>,
    <<0, 0, 0, 5>>,
    <<0, 0, 0, 6>>,
    <<0, 0, 0, 7>>,
    <<0, 0, 0, 8>>,
    <<0, 0, 0, 9>>
  ]

  describe "ConfigSettingID" do
    setup do
      %{
        codes: @codes,
        results: Enum.map(@codes, &ConfigSettingID.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ConfigSettingID{identifier: ^type} = ConfigSettingID.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ConfigSettingID.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} = ConfigSettingID.encode_xdr(%ConfigSettingID{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ConfigSettingID.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ConfigSettingID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ConfigSettingID.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = ConfigSettingID.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%ConfigSettingID{identifier: _}, ""} = ConfigSettingID.decode_xdr!(binary)
    end
  end
end
