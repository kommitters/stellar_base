defmodule Stellar.XDR.ExtTest do
  use ExUnit.Case

  alias Stellar.XDR.Ext

  describe "Ext" do
    setup do
      %{
        transaction_ext: Ext.new(),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{transaction_ext: transaction_ext} do
      ^transaction_ext = Ext.new()
    end

    test "encode_xdr/1", %{transaction_ext: transaction_ext, binary: binary} do
      {:ok, ^binary} = Ext.encode_xdr(transaction_ext)
    end

    test "encode_xdr!/1", %{transaction_ext: transaction_ext, binary: binary} do
      ^binary = Ext.encode_xdr!(transaction_ext)
    end

    test "decode_xdr/2", %{transaction_ext: transaction_ext, binary: binary} do
      {:ok, {^transaction_ext, ""}} = Ext.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Ext.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{transaction_ext: transaction_ext, binary: binary} do
      {^transaction_ext, ^binary} = Ext.decode_xdr!(binary <> binary)
    end
  end
end
