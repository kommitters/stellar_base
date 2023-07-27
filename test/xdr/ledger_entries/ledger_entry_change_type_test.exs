defmodule StellarBase.XDR.LedgerEntryChangeTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.LedgerEntryChangeType

  setup do
    types = [
      :LEDGER_ENTRY_CREATED,
      :LEDGER_ENTRY_UPDATED,
      :LEDGER_ENTRY_REMOVED,
      :LEDGER_ENTRY_STATE
    ]

    binary = <<0, 0, 0, 0>>
    ledger_entry_change_type = LedgerEntryChangeType.new()

    %{
      types: types,
      binary: binary,
      ledger_entry_change_type: ledger_entry_change_type
    }
  end

  test "new/1 with default type" do
    %StellarBase.XDR.LedgerEntryChangeType{identifier: :LEDGER_ENTRY_CREATED} =
      LedgerEntryChangeType.new()
  end

  test "new/1 with custom type", %{types: types} do
    for type <- types do
      %StellarBase.XDR.LedgerEntryChangeType{identifier: ^type} = LedgerEntryChangeType.new(type)
    end
  end

  test "encode_xdr/1", %{binary: binary} do
    {:ok, ^binary} = LedgerEntryChangeType.new() |> LedgerEntryChangeType.encode_xdr()
  end

  test "encode_xdr!/1", %{binary: binary} do
    ^binary = LedgerEntryChangeType.new() |> LedgerEntryChangeType.encode_xdr!()
  end

  test "decode_xdr/2", %{ledger_entry_change_type: ledger_entry_change_type, binary: binary} do
    {:ok, {^ledger_entry_change_type, ""}} = LedgerEntryChangeType.decode_xdr(binary)
  end

  test "decode_xdr!/2", %{ledger_entry_change_type: ledger_entry_change_type, binary: binary} do
    {^ledger_entry_change_type, ""} = LedgerEntryChangeType.decode_xdr!(binary)
  end

  test "decode_xdr/2 with invalid binary" do
    {:error, :not_binary} = LedgerEntryChangeType.decode_xdr(123)
  end
end
