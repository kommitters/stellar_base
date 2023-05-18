defmodule StellarBase.XDR.PoolIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Hash, PoolID}

  describe "PoolID" do
    setup do
      value = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      %{
        value: value,
        pool_id: PoolID.new(value),
        binary: value
      }
    end

    test "new/1", %{value: value} do
      %PoolID{pool_id: ^value} = PoolID.new(value)
    end

    test "encode_xdr/1", %{pool_id: pool_id, binary: binary} do
      {:ok, ^binary} = PoolID.encode_xdr(pool_id)
    end

    test "encode_xdr!/1 with an invalid PoolID length" do
      {:error, :invalid_length} = PoolID.encode_xdr(%PoolID{pool_id: <<0, 0, 4, 210, 33>>})
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
