defmodule StellarBase.XDR.Operations.AllowTrustResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.AllowTrustResultCode

  @codes [
    :ALLOW_TRUST_SUCCESS,
    :ALLOW_TRUST_MALFORMED,
    :ALLOW_TRUST_NO_TRUST_LINE,
    :ALLOW_TRUST_TRUST_NOT_REQUIRED,
    :ALLOW_TRUST_CANT_REVOKE,
    :ALLOW_TRUST_SELF_NOT_ALLOWED,
    :ALLOW_TRUST_LOW_RESERVE
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>,
    <<255, 255, 255, 250>>
  ]

  describe "AllowTrustResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> AllowTrustResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %AllowTrustResultCode{identifier: ^type} = AllowTrustResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = AllowTrustResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        AllowTrustResultCode.encode_xdr(%AllowTrustResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = AllowTrustResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = AllowTrustResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = AllowTrustResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = AllowTrustResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%AllowTrustResultCode{identifier: _}, ""} = AllowTrustResultCode.decode_xdr!(binary)
    end
  end
end
