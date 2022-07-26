defmodule StellarBase.XDR.OptionalLedgerBoundsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{UInt32, LedgerBounds, OptionalLedgerBounds}

  describe "OptionalLedgerBounds" do
    setup do
      min_ledger = UInt32.new(123)
      max_ledger = UInt32.new(321)

      ledger_bounds = LedgerBounds.new(min_ledger, max_ledger)

      %{
        ledger_bounds: ledger_bounds,
        optional_ledger_bounds: OptionalLedgerBounds.new(ledger_bounds),
        binary: <<0, 0, 0, 1, 0, 0, 0, 123, 0, 0, 1, 65>>
      }
    end

    test "new/1", %{ledger_bounds: ledger_bounds} do
      %OptionalLedgerBounds{ledger_bounds: ^ledger_bounds} =
        OptionalLedgerBounds.new(ledger_bounds)
    end

    test "encode_xdr/1", %{optional_ledger_bounds: optional_ledger_bounds, binary: binary} do
      {:ok, ^binary} = OptionalLedgerBounds.encode_xdr(optional_ledger_bounds)
    end

    test "encode_xdr!/1", %{optional_ledger_bounds: optional_ledger_bounds, binary: binary} do
      ^binary = OptionalLedgerBounds.encode_xdr!(optional_ledger_bounds)
    end

    test "decode_xdr/2", %{optional_ledger_bounds: optional_ledger_bounds, binary: binary} do
      {:ok, {^optional_ledger_bounds, ""}} = OptionalLedgerBounds.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalLedgerBounds.decode_xdr(1234)
    end

    test "decode_xdr/2 when ledger_bounds are not opted" do
      no_ledger_bounds = <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>

      {:ok,
       {%OptionalLedgerBounds{ledger_bounds: nil},
        <<0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>}} =
        OptionalLedgerBounds.decode_xdr(no_ledger_bounds)
    end

    test "decode_xdr!/2", %{optional_ledger_bounds: optional_ledger_bounds, binary: binary} do
      {^optional_ledger_bounds, ^binary} = OptionalLedgerBounds.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when ledger_bounds are not opted" do
      no_ledger_bounds = <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>

      {%OptionalLedgerBounds{ledger_bounds: nil},
       <<0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>} =
        OptionalLedgerBounds.decode_xdr!(no_ledger_bounds)
    end
  end
end
