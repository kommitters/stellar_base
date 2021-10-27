defmodule Stellar.XDR.TransactionResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.TransactionResultCode

  describe "TransactionResultCode" do
    setup do
      %{
        code: :txSUCCESS,
        result: TransactionResultCode.new(:txSUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %TransactionResultCode{identifier: ^type} = TransactionResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = TransactionResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        TransactionResultCode.encode_xdr(%TransactionResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = TransactionResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = TransactionResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = TransactionResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = TransactionResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%TransactionResultCode{identifier: :txTOO_EARLY}, ""} =
        TransactionResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
