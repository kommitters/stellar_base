defmodule Stellar.XDR.MemoTest do
  use ExUnit.Case

  alias Stellar.XDR.{UInt64, Hash, String28, MemoType, Memo}

  describe "Memo" do
    setup do
      memo_type = MemoType.new(:MEMO_ID)
      memo_id = UInt64.new(12_345)

      %{
        memo_type_id: :MEMO_ID,
        memo_type: memo_type,
        memo_id: memo_id,
        memo: Memo.new(memo_id, memo_type),
        binary: <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 48, 57>>
      }
    end

    test "new/1", %{memo_type_id: type_id, memo_type: memo_type, memo_id: memo_id} do
      %Memo{type: %MemoType{identifier: ^type_id}} = Memo.new(memo_id, memo_type)
    end

    test "encode_xdr/1", %{memo: memo, binary: binary} do
      {:ok, ^binary} = Memo.encode_xdr(memo)
    end

    test "encode_xdr/1 with an invalid type", %{memo_id: memo_id} do
      memo_type = MemoType.new(:MEMO_TESTER)

      assert_raise XDR.EnumError,
                   "The key which you try to encode doesn't belong to the current declarations",
                   fn ->
                     memo_id
                     |> Memo.new(memo_type)
                     |> Memo.encode_xdr()
                   end
    end

    test "encode_xdr/1 a MEMO_HASH" do
      memo_type = MemoType.new(:MEMO_HASH)
      memo_hash = Hash.new("GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN")

      {:ok, _binary} = memo_hash |> Memo.new(memo_type) |> Memo.encode_xdr()
    end

    test "encode_xdr/1 a nil value" do
      memo_type = MemoType.new(:MEMO_HASH)

      assert_raise XDR.FixedOpaqueError,
                   "The value which you pass through parameters must be a binary value, for example: <<0, 0, 0, 5>>",
                   fn ->
                     nil
                     |> Memo.new(memo_type)
                     |> Memo.encode_xdr()
                   end
    end

    test "encode_xdr!/1", %{memo: memo, binary: binary} do
      ^binary = Memo.encode_xdr!(memo)
    end

    test "encode_xdr/1 with an invalid value" do
      memo_type = MemoType.new(:MEMO_ID)
      memo_id = String28.new("abcd1234")

      assert_raise XDR.HyperUIntError,
                   "The value which you try to encode is not an integer",
                   fn ->
                     memo_id
                     |> Memo.new(memo_type)
                     |> Memo.encode_xdr()
                   end
    end

    test "decode_xdr/2", %{memo: memo, binary: binary} do
      {:ok, {^memo, ""}} = Memo.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Memo.decode_xdr(123)
    end

    test "decode_xdr!/2", %{memo: memo, binary: binary} do
      {^memo, ^binary} = Memo.decode_xdr!(binary <> binary)
    end
  end
end
