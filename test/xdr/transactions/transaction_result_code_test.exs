defmodule StellarBase.XDR.TransactionResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.TransactionResultCode

  @codes [
    :txFEE_BUMP_INNER_SUCCESS,
    :txSUCCESS,
    :txFAILED,
    :txTOO_EARLY,
    :txTOO_LATE,
    :txMISSING_OPERATION,
    :txBAD_SEQ,
    :txBAD_AUTH,
    :txINSUFFICIENT_BALANCE,
    :txNO_ACCOUNT,
    :txINSUFFICIENT_FEE,
    :txBAD_AUTH_EXTRA,
    :txINTERNAL_ERROR,
    :txNOT_SUPPORTED,
    :txFEE_BUMP_INNER_FAILED,
    :txBAD_SPONSORSHIP
  ]

  @binaries [
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>,
    <<255, 255, 255, 250>>,
    <<255, 255, 255, 249>>,
    <<255, 255, 255, 248>>,
    <<255, 255, 255, 247>>,
    <<255, 255, 255, 246>>,
    <<255, 255, 255, 245>>,
    <<255, 255, 255, 244>>,
    <<255, 255, 255, 243>>,
    <<255, 255, 255, 242>>
  ]

  describe "TransactionResultCode" do
    setup do
      %{
        code: :txSUCCESS,
        results: @codes |> Enum.map(fn code -> TransactionResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{code: type} do
      %TransactionResultCode{identifier: ^type} = TransactionResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = TransactionResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        TransactionResultCode.encode_xdr(%TransactionResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = TransactionResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = TransactionResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = TransactionResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = TransactionResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%TransactionResultCode{identifier: _}, ""} =
              TransactionResultCode.decode_xdr!(binary)
    end
  end
end
