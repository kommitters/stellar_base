defmodule StellarBase.XDR.EvictionIteratorTest do
  use ExUnit.Case

  alias StellarBase.XDR.{EvictionIterator, Bool, UInt32, UInt64}

  setup do
    bucket_list_level = UInt32.new(10)
    is_curr_bucket = Bool.new(true)
    bucket_file_offset = UInt64.new(10)

    eviction_iterator =
      EvictionIterator.new(
        bucket_list_level,
        is_curr_bucket,
        bucket_file_offset
      )

    %{
      bucket_list_level: bucket_list_level,
      is_curr_bucket: is_curr_bucket,
      bucket_file_offset: bucket_file_offset,
      eviction_iterator: eviction_iterator,
      binary: <<0, 0, 0, 10, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 10>>
    }
  end

  test "new/1", %{
    bucket_list_level: bucket_list_level,
    is_curr_bucket: is_curr_bucket,
    bucket_file_offset: bucket_file_offset
  } do
    %EvictionIterator{
      bucket_list_level: ^bucket_list_level,
      is_curr_bucket: ^is_curr_bucket,
      bucket_file_offset: ^bucket_file_offset
    } =
      EvictionIterator.new(
        bucket_list_level,
        is_curr_bucket,
        bucket_file_offset
      )
  end

  test "encode_xdr/1", %{
    eviction_iterator: eviction_iterator,
    binary: binary
  } do
    {:ok, ^binary} = EvictionIterator.encode_xdr(eviction_iterator)
  end

  test "encode_xdr!/1", %{
    eviction_iterator: eviction_iterator,
    binary: binary
  } do
    ^binary = EvictionIterator.encode_xdr!(eviction_iterator)
  end

  test "decode_xdr/2", %{
    eviction_iterator: eviction_iterator,
    binary: binary
  } do
    {:ok, {^eviction_iterator, ""}} = EvictionIterator.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = EvictionIterator.decode_xdr(123)
  end

  test "decode_xdr!/2", %{
    eviction_iterator: eviction_iterator,
    binary: binary
  } do
    {^eviction_iterator, ^binary} = EvictionIterator.decode_xdr!(binary <> binary)
  end
end
