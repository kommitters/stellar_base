defmodule StellarBase.XDR.LedgerKeyExpirationTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Hash, LedgerKeyExpiration}

  describe "LedgerKeyExpiration" do
    setup do
      hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        hash: hash,
        ledger_expiration: LedgerKeyExpiration.new(hash),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1", %{hash: hash} do
      %LedgerKeyExpiration{key_hash: ^hash} = LedgerKeyExpiration.new(hash)
    end

    test "encode_xdr/1", %{ledger_expiration: ledger_expiration, binary: binary} do
      {:ok, ^binary} = LedgerKeyExpiration.encode_xdr(ledger_expiration)
    end

    test "encode_xdr!/1", %{ledger_expiration: ledger_expiration, binary: binary} do
      ^binary = LedgerKeyExpiration.encode_xdr!(ledger_expiration)
    end

    test "decode_xdr/2", %{ledger_expiration: ledger_expiration, binary: binary} do
      {:ok, {^ledger_expiration, ""}} = LedgerKeyExpiration.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{ledger_expiration: ledger_expiration, binary: binary} do
      {^ledger_expiration, ^binary} = LedgerKeyExpiration.decode_xdr!(binary <> binary)
    end

    test "decode_xdr/2 with invalid binary" do
      {:error, :not_binary} = LedgerKeyExpiration.decode_xdr(123)
    end
  end
end
