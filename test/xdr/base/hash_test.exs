defmodule StellarBase.XDR.HashTest do
  use ExUnit.Case

  alias StellarBase.XDR.Hash

  describe "Hash" do
    setup do
      %{
        hash: Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"),
        binary: "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      }
    end

    test "new/1" do
      value = "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      %Hash{value: ^value} = Hash.new(value)
    end

    test "encode_xdr/1", %{hash: hash, binary: binary} do
      {:ok, ^binary} = Hash.encode_xdr(hash)
    end

    test "encode_xdr!/1 with an invalid hash length" do
      {:error, :invalid_length} = Hash.encode_xdr(%Hash{value: <<0, 0, 4, 210, 33>>})
    end

    test "encode_xdr!/1", %{hash: hash, binary: binary} do
      ^binary = Hash.encode_xdr!(hash)
    end

    test "decode_xdr/2", %{hash: hash, binary: binary} do
      {:ok, {^hash, ""}} = Hash.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Hash.decode_xdr(123)
    end

    test "decode_xdr!/2", %{hash: hash, binary: binary} do
      {^hash, ""} = Hash.decode_xdr!(binary)
    end
  end
end
