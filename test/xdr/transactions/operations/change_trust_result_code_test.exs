defmodule StellarBase.XDR.ChangeTrustResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ChangeTrustResultCode

  @codes [
    :CHANGE_TRUST_SUCCESS,
    :CHANGE_TRUST_MALFORMED,
    :CHANGE_TRUST_NO_ISSUER,
    :CHANGE_TRUST_INVALID_LIMIT,
    :CHANGE_TRUST_LOW_RESERVE,
    :CHANGE_TRUST_SELF_NOT_ALLOWED,
    :CHANGE_TRUST_TRUST_LINE_MISSING,
    :CHANGE_TRUST_CANNOT_DELETE,
    :CHANGE_TRUST_NOT_AUTH_MAINTAIN_LIABILITIES
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>,
    <<255, 255, 255, 250>>,
    <<255, 255, 255, 249>>,
    <<255, 255, 255, 248>>
  ]

  describe "ChangeTrustResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> ChangeTrustResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ChangeTrustResultCode{identifier: ^type} = ChangeTrustResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ChangeTrustResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ChangeTrustResultCode.encode_xdr(%ChangeTrustResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ChangeTrustResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ChangeTrustResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ChangeTrustResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = ChangeTrustResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%ChangeTrustResultCode{identifier: _}, ""} =
              ChangeTrustResultCode.decode_xdr!(binary)
    end
  end
end
