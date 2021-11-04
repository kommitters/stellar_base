defmodule StellarBase.XDR.Operations.AccountMergeResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Int64
  alias StellarBase.XDR.Operations.{AccountMergeResult, AccountMergeResultCode}

  describe "AccountMergeResult" do
    setup do
      code = AccountMergeResultCode.new(:ACCOUNT_MERGE_SUCCESS)
      value = Int64.new(100_000_000)

      %{
        code: code,
        value: value,
        result: AccountMergeResult.new(value, code),
        binary: <<0, 0, 0, 0, 0, 0, 0, 0, 5, 245, 225, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %AccountMergeResult{code: ^code, result: ^value} = AccountMergeResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = AccountMergeResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = AccountMergeResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value" do
      code = AccountMergeResultCode.new(:ACCOUNT_MERGE_NO_ACCOUNT)

      <<255, 255, 255, 254>> =
        "TEST"
        |> AccountMergeResult.new(code)
        |> AccountMergeResult.encode_xdr!()
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = AccountMergeResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = AccountMergeResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%AccountMergeResult{
         code: %AccountMergeResultCode{identifier: :ACCOUNT_MERGE_NO_ACCOUNT}
       }, ""} = AccountMergeResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AccountMergeResult.decode_xdr(123)
    end
  end
end
