defmodule Stellar.XDR.TransactionExtTest do
  use ExUnit.Case

  alias Stellar.XDR.TransactionExt

  describe "TransactionExt" do
    setup do
      %{
        transaction_ext: TransactionExt.new(),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{transaction_ext: transaction_ext} do
      ^transaction_ext = TransactionExt.new()
    end

    test "encode_xdr/1", %{transaction_ext: transaction_ext, binary: binary} do
      {:ok, ^binary} = TransactionExt.encode_xdr(transaction_ext)
    end

    test "encode_xdr!/1", %{transaction_ext: transaction_ext, binary: binary} do
      ^binary = TransactionExt.encode_xdr!(transaction_ext)
    end

    test "decode_xdr/2", %{transaction_ext: transaction_ext, binary: binary} do
      {:ok, {^transaction_ext, ""}} = TransactionExt.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{transaction_ext: transaction_ext, binary: binary} do
      {^transaction_ext, ^binary} = TransactionExt.decode_xdr!(binary <> binary)
    end
  end
end
