defmodule StellarBase.XDR.ExpirationEntryTest do
  use ExUnit.Case
  alias StellarBase.XDR.ExpirationEntry
  alias StellarBase.XDR.{Hash, UInt32}

  describe "ExpirationEntry" do
    setup do
      key_hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
      expiration_ledger_seq = UInt32.new(123)
      expiration_entry = ExpirationEntry.new(key_hash, expiration_ledger_seq)

      binary =
        <<71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54, 52, 84, 72,
          77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 123>>

      %{
        key_hash: key_hash,
        expiration_ledger_seq: expiration_ledger_seq,
        expiration_entry: expiration_entry,
        binary: binary
      }
    end

    test "new/2", %{key_hash: key_hash, expiration_ledger_seq: expiration_ledger_seq} do
      %StellarBase.XDR.ExpirationEntry{
        key_hash: ^key_hash,
        expiration_ledger_seq: ^expiration_ledger_seq
      } = ExpirationEntry.new(key_hash, expiration_ledger_seq)
    end

    test "encode_xdr/1", %{expiration_entry: expiration_entry, binary: binary} do
      {:ok, ^binary} = ExpirationEntry.encode_xdr(expiration_entry)
    end

    test "encode_xdr!/1", %{expiration_entry: expiration_entry, binary: binary} do
      ^binary = ExpirationEntry.encode_xdr!(expiration_entry)
    end

    test "decode_xdr/2", %{binary: binary, expiration_entry: expiration_entry} do
      {:ok, {^expiration_entry, ""}} = ExpirationEntry.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{binary: binary, expiration_entry: expiration_entry} do
      {^expiration_entry, ""} = ExpirationEntry.decode_xdr!(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ExpirationEntry.decode_xdr(123)
    end
  end
end
