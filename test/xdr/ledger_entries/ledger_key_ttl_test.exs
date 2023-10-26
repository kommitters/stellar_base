defmodule StellarBase.XDR.LedgerKeyTTLTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Hash, LedgerKeyTTL}

  describe "LedgerKeyTTL" do
    setup do
      hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        hash: hash,
        ledger_expiration: LedgerKeyTTL.new(hash),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1", %{hash: hash} do
      %LedgerKeyTTL{key_hash: ^hash} = LedgerKeyTTL.new(hash)
    end

    test "encode_xdr/1", %{ledger_expiration: ledger_expiration, binary: binary} do
      {:ok, ^binary} = LedgerKeyTTL.encode_xdr(ledger_expiration)
    end

    test "encode_xdr!/1", %{ledger_expiration: ledger_expiration, binary: binary} do
      ^binary = LedgerKeyTTL.encode_xdr!(ledger_expiration)
    end

    test "decode_xdr/2", %{ledger_expiration: ledger_expiration, binary: binary} do
      {:ok, {^ledger_expiration, ""}} = LedgerKeyTTL.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{ledger_expiration: ledger_expiration, binary: binary} do
      {^ledger_expiration, ^binary} = LedgerKeyTTL.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with invalid binary" do
      {:error, :not_binary} = LedgerKeyTTL.decode_xdr(123)
    end
  end
end
