defmodule StellarBase.XDR.MemoTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.MemoType

  describe "MemoType" do
    setup do
      %{
        identifier: :MEMO_TEXT,
        memo_type: MemoType.new(:MEMO_TEXT),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1", %{identifier: type} do
      %MemoType{identifier: ^type} = MemoType.new(type)
    end

    test "new/1 with a default type" do
      %MemoType{identifier: :MEMO_NONE} = MemoType.new()
    end

    test "encode_xdr/1", %{memo_type: memo_type, binary: binary} do
      {:ok, ^binary} = MemoType.encode_xdr(memo_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} = MemoType.encode_xdr(%MemoType{identifier: MEMO_TEST})
    end

    test "encode_xdr!/1", %{memo_type: memo_type, binary: binary} do
      ^binary = MemoType.encode_xdr!(memo_type)
    end

    test "decode_xdr/2", %{memo_type: memo_type, binary: binary} do
      {:ok, {^memo_type, ""}} = MemoType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = MemoType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{memo_type: memo_type, binary: binary} do
      {^memo_type, ^binary} = MemoType.decode_xdr!(binary <> binary)
    end
  end
end
