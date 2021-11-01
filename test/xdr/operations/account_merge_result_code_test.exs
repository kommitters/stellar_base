defmodule Stellar.XDR.Operations.AccountMergeResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.AccountMergeResultCode

  describe "AccountMergeResultCode" do
    setup do
      %{
        code: :ACCOUNT_MERGE_SUCCESS,
        result: AccountMergeResultCode.new(:ACCOUNT_MERGE_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %AccountMergeResultCode{identifier: ^type} = AccountMergeResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = AccountMergeResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        AccountMergeResultCode.encode_xdr(%AccountMergeResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = AccountMergeResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = AccountMergeResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = AccountMergeResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = AccountMergeResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%AccountMergeResultCode{identifier: :ACCOUNT_MERGE_NO_ACCOUNT}, ""} =
        AccountMergeResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
