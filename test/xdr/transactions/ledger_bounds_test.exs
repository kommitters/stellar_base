defmodule StellarBase.XDR.LedgerBoundsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Uint32, LedgerBounds}

  describe "LedgerBounds" do
    setup do
      min_ledger = Uint32.new(123)
      max_ledger = Uint32.new(321)

      %{
        min_ledger: min_ledger,
        max_ledger: max_ledger,
        time_bounds: LedgerBounds.new(min_ledger, max_ledger),
        binary: <<0, 0, 0, 123, 0, 0, 1, 65>>
      }
    end

    test "new/1", %{min_ledger: min_ledger, max_ledger: max_ledger} do
      %LedgerBounds{min_ledger: ^min_ledger, max_ledger: ^max_ledger} =
        LedgerBounds.new(min_ledger, max_ledger)
    end

    test "encode_xdr/1", %{time_bounds: time_bounds, binary: binary} do
      {:ok, ^binary} = LedgerBounds.encode_xdr(time_bounds)
    end

    test "encode_xdr!/1", %{time_bounds: time_bounds, binary: binary} do
      ^binary = LedgerBounds.encode_xdr!(time_bounds)
    end

    test "decode_xdr/2", %{time_bounds: time_bounds, binary: binary} do
      {:ok, {^time_bounds, ""}} = LedgerBounds.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = LedgerBounds.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{time_bounds: time_bounds, binary: binary} do
      {^time_bounds, ^binary} = LedgerBounds.decode_xdr!(binary <> binary)
    end
  end
end
