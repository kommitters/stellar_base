defmodule StellarBase.XDR.Operations.SetTrustLineFlagsResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.SetTrustLineFlagsResultCode

  @codes [
    :SET_TRUST_LINE_FLAGS_SUCCESS,
    :SET_TRUST_LINE_FLAGS_MALFORMED,
    :SET_TRUST_LINE_FLAGS_NO_TRUST_LINE,
    :SET_TRUST_LINE_FLAGS_CANT_REVOKE,
    :SET_TRUST_LINE_FLAGS_INVALID_STATE,
    :SET_TRUST_LINE_FLAGS_LOW_RESERVE
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>
  ]

  describe "SetTrustLineFlagsResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> SetTrustLineFlagsResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %SetTrustLineFlagsResultCode{identifier: ^type} =
              SetTrustLineFlagsResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SetTrustLineFlagsResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        SetTrustLineFlagsResultCode.encode_xdr(%SetTrustLineFlagsResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SetTrustLineFlagsResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SetTrustLineFlagsResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SetTrustLineFlagsResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SetTrustLineFlagsResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%SetTrustLineFlagsResultCode{identifier: _}, ""} =
              SetTrustLineFlagsResultCode.decode_xdr!(binary)
    end
  end
end
