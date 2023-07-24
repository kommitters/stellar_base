defmodule StellarBase.XDR.ConfigSettingContractExecutionLanesV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{ConfigSettingContractExecutionLanesV0, UInt32}

  setup do
    %{
      ledger_max_tx_count: UInt32.new(100),
      binary: <<0, 0, 0, 100>>
    }
  end

  test "new/1", %{ledger_max_tx_count: ledger_max_tx_count} do
    %ConfigSettingContractExecutionLanesV0{
      ledger_max_tx_count: ^ledger_max_tx_count
    } = ConfigSettingContractExecutionLanesV0.new(ledger_max_tx_count)
  end

  test "encode_xdr/1", %{ledger_max_tx_count: ledger_max_tx_count, binary: binary} do
    {:ok, ^binary} =
      ConfigSettingContractExecutionLanesV0.new(ledger_max_tx_count)
      |> ConfigSettingContractExecutionLanesV0.encode_xdr()
  end

  test "encode_xdr!/1", %{ledger_max_tx_count: ledger_max_tx_count, binary: binary} do
    ^binary =
      ConfigSettingContractExecutionLanesV0.new(ledger_max_tx_count)
      |> ConfigSettingContractExecutionLanesV0.encode_xdr!()
  end

  test "decode_xdr/2", %{ledger_max_tx_count: ledger_max_tx_count} do
    {:ok, {%ConfigSettingContractExecutionLanesV0{ledger_max_tx_count: ^ledger_max_tx_count}, ""}} =
      ConfigSettingContractExecutionLanesV0.decode_xdr(<<0, 0, 0, 100>>)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = ConfigSettingContractExecutionLanesV0.decode_xdr(123)
  end

  test "decode_xdr!/2", %{ledger_max_tx_count: ledger_max_tx_count} do
    {decoded, _rest} =
      ConfigSettingContractExecutionLanesV0.decode_xdr!(<<0, 0, 0, 100>> <> <<0, 0, 0, 50>>)

    assert %ConfigSettingContractExecutionLanesV0{ledger_max_tx_count: ^ledger_max_tx_count} =
             decoded
  end
end
