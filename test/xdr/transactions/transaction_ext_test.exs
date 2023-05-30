defmodule StellarBase.XDR.TransactionExtTest do
  use ExUnit.Case

  alias StellarBase.XDR.{TransactionExt, Void}

  describe "TransactionExt" do
    setup do
      %{
        value: Void.new(),
        type: 0,
        transaction_ext: TransactionExt.new(Void.new(), 0),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{value: value, type: type, transaction_ext: transaction_ext} do
      ^transaction_ext = TransactionExt.new(value, type)
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

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TransactionExt.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{transaction_ext: transaction_ext, binary: binary} do
      {^transaction_ext, ^binary} = TransactionExt.decode_xdr!(binary <> binary)
    end
  end
end
