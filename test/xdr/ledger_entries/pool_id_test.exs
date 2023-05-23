defmodule StellarBase.XDR.PoolIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Hash, PoolID}

  describe "PoolID" do
    setup do
      value = "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
      hash_value = Hash.new(value)

      %{
        hash_value: hash_value,
        pool_id: PoolID.new(hash_value),
        binary: value
      }
    end

    test "new/1", %{hash_value: hash_value} do
      %PoolID{pool_id: ^hash_value} = PoolID.new(hash_value)
    end

    test "encode_xdr/1", %{pool_id: pool_id, binary: binary} do
      {:ok, ^binary} = PoolID.encode_xdr(pool_id)
    end

    test "encode_xdr!/1 with an invalid PoolID length" do
      {:error, :invalid_length} =
        <<0, 0, 4, 210, 33>> |> Hash.new() |> PoolID.new() |> PoolID.encode_xdr()
    end

    test "encode_xdr!/1", %{pool_id: pool_id, binary: binary} do
      ^binary = PoolID.encode_xdr!(pool_id)
    end

    test "decode_xdr/2", %{pool_id: pool_id, binary: binary} do
      {:ok, {^pool_id, ""}} = PoolID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PoolID.decode_xdr(123)
    end

    test "decode_xdr!/2", %{pool_id: pool_id, binary: binary} do
      {^pool_id, ""} = PoolID.decode_xdr!(binary)
    end
  end
end
