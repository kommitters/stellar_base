defmodule StellarBase.XDR.Operations.ClawbackClaimableBalanceResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.ClawbackClaimableBalanceResultCode

  @codes [
    :CLAWBACK_CLAIMABLE_BALANCE_SUCCESS,
    :CLAWBACK_CLAIMABLE_BALANCE_DOES_NOT_EXIST,
    :CLAWBACK_CLAIMABLE_BALANCE_NOT_ISSUER,
    :CLAWBACK_CLAIMABLE_BALANCE_NOT_CLAWBACK_ENABLED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>
  ]

  describe "ClawbackClaimableBalanceResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> ClawbackClaimableBalanceResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %ClawbackClaimableBalanceResultCode{identifier: ^type} =
              ClawbackClaimableBalanceResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ClawbackClaimableBalanceResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ClawbackClaimableBalanceResultCode.encode_xdr(%ClawbackClaimableBalanceResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ClawbackClaimableBalanceResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ClawbackClaimableBalanceResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClawbackClaimableBalanceResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do:
            {^result, ^binary} = ClawbackClaimableBalanceResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%ClawbackClaimableBalanceResultCode{
               identifier: _
             }, ""} = ClawbackClaimableBalanceResultCode.decode_xdr!(binary)
    end
  end
end
