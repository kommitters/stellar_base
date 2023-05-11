defmodule StellarBase.XDR.SetOptionsResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SetOptionsResultCode

  @codes [
    :SET_OPTIONS_SUCCESS,
    :SET_OPTIONS_LOW_RESERVE,
    :SET_OPTIONS_TOO_MANY_SIGNERS,
    :SET_OPTIONS_BAD_FLAGS,
    :SET_OPTIONS_INVALID_INFLATION,
    :SET_OPTIONS_CANT_CHANGE,
    :SET_OPTIONS_UNKNOWN_FLAG,
    :SET_OPTIONS_THRESHOLD_OUT_OF_RANGE,
    :SET_OPTIONS_BAD_SIGNER,
    :SET_OPTIONS_INVALID_HOME_DOMAIN,
    :SET_OPTIONS_AUTH_REVOCABLE_REQUIRED
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
    <<255, 255, 255, 248>>,
    <<255, 255, 255, 247>>,
    <<255, 255, 255, 246>>
  ]

  describe "SetOptionsResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> SetOptionsResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %SetOptionsResultCode{identifier: ^type} = SetOptionsResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SetOptionsResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        SetOptionsResultCode.encode_xdr(%SetOptionsResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SetOptionsResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SetOptionsResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SetOptionsResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SetOptionsResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%SetOptionsResultCode{identifier: _}, ""} = SetOptionsResultCode.decode_xdr!(binary)
    end
  end
end
