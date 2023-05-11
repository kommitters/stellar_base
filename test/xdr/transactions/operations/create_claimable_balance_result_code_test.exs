defmodule StellarBase.XDR.CreateClaimableBalanceResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.CreateClaimableBalanceResultCode

  @codes [
    :CREATE_CLAIMABLE_BALANCE_SUCCESS,
    :CREATE_CLAIMABLE_BALANCE_MALFORMED,
    :CREATE_CLAIMABLE_BALANCE_LOW_RESERVE,
    :CREATE_CLAIMABLE_BALANCE_NO_TRUST,
    :CREATE_CLAIMABLE_BALANCE_NOT_AUTHORIZED,
    :CREATE_CLAIMABLE_BALANCE_UNDERFUNDED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>
  ]

  describe "CreateClaimableBalanceResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> CreateClaimableBalanceResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %CreateClaimableBalanceResultCode{identifier: ^type} =
              CreateClaimableBalanceResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = CreateClaimableBalanceResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        CreateClaimableBalanceResultCode.encode_xdr(%CreateClaimableBalanceResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = CreateClaimableBalanceResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = CreateClaimableBalanceResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = CreateClaimableBalanceResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = CreateClaimableBalanceResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%CreateClaimableBalanceResultCode{identifier: _}, ""} =
              CreateClaimableBalanceResultCode.decode_xdr!(binary)
    end
  end
end
