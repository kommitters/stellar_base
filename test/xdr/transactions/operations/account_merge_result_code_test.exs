defmodule StellarBase.XDR.Operations.AccountMergeResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.AccountMergeResultCode

  @codes [
    :ACCOUNT_MERGE_SUCCESS,
    :ACCOUNT_MERGE_MALFORMED,
    :ACCOUNT_MERGE_NO_ACCOUNT,
    :ACCOUNT_MERGE_IMMUTABLE_SET,
    :ACCOUNT_MERGE_HAS_SUB_ENTRIES,
    :ACCOUNT_MERGE_SEQNUM_TOO_FAR,
    :ACCOUNT_MERGE_DEST_FULL,
    :ACCOUNT_MERGE_IS_SPONSOR
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>,
    <<255, 255, 255, 250>>,
    <<255, 255, 255, 249>>
  ]

  describe "AccountMergeResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> AccountMergeResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %AccountMergeResultCode{identifier: ^type} = AccountMergeResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = AccountMergeResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        AccountMergeResultCode.encode_xdr(%AccountMergeResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = AccountMergeResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = AccountMergeResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = AccountMergeResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = AccountMergeResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%AccountMergeResultCode{identifier: _}, ""} =
              AccountMergeResultCode.decode_xdr!(binary)
    end
  end
end
