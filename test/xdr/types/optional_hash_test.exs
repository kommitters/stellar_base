defmodule StellarBase.XDR.OptionalHashTest do
  use ExUnit.Case

  alias StellarBase.XDR.{OptionalHash, Hash}

  setup do
    valid_hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")
    invalid_hash = Hash.new("INVALID")
    binary = <<0, 0, 0, 0>>

    binary_with_hash =
      <<0, 0, 0, 1, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80, 54,
        52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>

    optional_hash = OptionalHash.new()

    %{
      valid_hash: valid_hash,
      invalid_hash: invalid_hash,
      binary: binary,
      binary_with_hash: binary_with_hash,
      optional_hash: optional_hash,
      hash: OptionalHash.new(valid_hash)
    }
  end

  test "new/1" do
    %OptionalHash{} = OptionalHash.new()
  end

  test "new/1 with valid hash", %{valid_hash: valid_hash} do
    %OptionalHash{hash: ^valid_hash} = OptionalHash.new(valid_hash)
  end

  test "encode_xdr/1", %{binary: binary} do
    {:ok, ^binary} = OptionalHash.new() |> OptionalHash.encode_xdr()
  end

  test "encode_xdr!/1", %{binary: binary} do
    ^binary = OptionalHash.new() |> OptionalHash.encode_xdr!()
  end

  test "decode_xdr/2", %{optional_hash: optional_hash, binary: binary} do
    {:ok, {^optional_hash, ""}} = OptionalHash.decode_xdr(binary)
  end

  test "decode_xdr!/2", %{optional_hash: optional_hash, binary: binary} do
    {^optional_hash, ""} = OptionalHash.decode_xdr!(binary)
  end

  test "decode_xdr/2 with hash", %{hash: hash, binary_with_hash: binary_with_hash} do
    {:ok, {^hash, ""}} = OptionalHash.decode_xdr(binary_with_hash)
  end

  test "decode_xdr!/2 with hash", %{hash: hash, binary_with_hash: binary_with_hash} do
    {^hash, ""} = OptionalHash.decode_xdr!(binary_with_hash)
  end

  test "decode_xdr/2 with invalid binary" do
    {:error, :not_binary} = OptionalHash.decode_xdr(123)
  end
end
