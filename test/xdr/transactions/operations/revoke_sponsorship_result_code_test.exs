defmodule StellarBase.XDR.Operations.RevokeSponsorshipResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.RevokeSponsorshipResultCode

  @codes [
    :REVOKE_SPONSORSHIP_SUCCESS,
    :REVOKE_SPONSORSHIP_DOES_NOT_EXIST,
    :REVOKE_SPONSORSHIP_NOT_SPONSOR,
    :REVOKE_SPONSORSHIP_LOW_RESERVE,
    :REVOKE_SPONSORSHIP_ONLY_TRANSFERABLE,
    :REVOKE_SPONSORSHIP_MALFORMED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>
  ]

  describe "RevokeSponsorshipResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> RevokeSponsorshipResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %RevokeSponsorshipResultCode{identifier: ^type} =
              RevokeSponsorshipResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = RevokeSponsorshipResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        RevokeSponsorshipResultCode.encode_xdr(%RevokeSponsorshipResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = RevokeSponsorshipResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = RevokeSponsorshipResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = RevokeSponsorshipResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = RevokeSponsorshipResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%RevokeSponsorshipResultCode{identifier: _}, ""} =
              RevokeSponsorshipResultCode.decode_xdr!(binary)
    end
  end
end
