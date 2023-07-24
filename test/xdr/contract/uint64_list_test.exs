defmodule StellarBase.XDR.UInt64ListTest do
  use ExUnit.Case

  alias StellarBase.XDR.{UInt64, UInt64List}

  setup do
    list_items = [123, 456, 789]

    encoded_result =
      <<0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 200, 0, 0, 0, 0, 0, 0, 3, 21>>

    uint64_items = Enum.map(list_items, &UInt64.new/1)
    uint64_list = UInt64List.new(uint64_items)

    %{
      list_items: list_items,
      uint64_items: uint64_items,
      uint64_list: uint64_list,
      encoded_result: encoded_result
    }
  end

  test "new/1", %{uint64_items: uint64_items} do
    %UInt64List{items: ^uint64_items} = UInt64List.new(uint64_items)
  end

  test "encode_xdr/1", %{uint64_list: uint64_list, encoded_result: encoded_result} do
    {:ok, ^encoded_result} = UInt64List.encode_xdr(uint64_list)
  end

  test "encode_xdr!/1", %{uint64_list: uint64_list, encoded_result: encoded_result} do
    ^encoded_result = UInt64List.encode_xdr!(uint64_list)
  end

  test "decode_xdr/2", %{uint64_list: uint64_list} do
    {:ok, {^uint64_list, ""}} = UInt64List.decode_xdr(UInt64List.encode_xdr!(uint64_list))
  end

  test "decode_xdr!/2", %{uint64_list: uint64_list} do
    {^uint64_list, ""} = UInt64List.decode_xdr!(UInt64List.encode_xdr!(uint64_list))
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = UInt64List.decode_xdr(123)
  end
end
