defmodule StellarBase.XDR.Operations.ClawbackResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.ClawbackResultCode

  @codes [
    :CLAWBACK_SUCCESS,
    :CLAWBACK_MALFORMED,
    :CLAWBACK_NOT_CLAWBACK_ENABLED,
    :CLAWBACK_NO_TRUST,
    :CLAWBACK_UNDERFUNDED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>
  ]

  describe "ClawbackResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> ClawbackResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ClawbackResultCode{identifier: ^type} = ClawbackResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ClawbackResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ClawbackResultCode.encode_xdr(%ClawbackResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ClawbackResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ClawbackResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClawbackResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = ClawbackResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%ClawbackResultCode{identifier: _}, ""} = ClawbackResultCode.decode_xdr!(binary)
    end
  end
end
