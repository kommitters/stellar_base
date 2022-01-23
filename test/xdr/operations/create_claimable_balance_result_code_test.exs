defmodule StellarBase.XDR.Operations.CreateClaimableBalanceResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.CreateClaimableBalanceResultCode

  @codes [
    :CREATE_CLAIMABLE_BALANCE_SUCCESS,
    :CREATE_CLAIMABLE_BALANCE_MALFORMED,
    :CREATE_CLAIMABLE_BALANCE_LOW_RESERVE,
    :CREATE_CLAIMABLE_BALANCE_NO_TRUST,
    :CREATE_CLAIMABLE_BALANCE_NOT_AUTHORIZED,
    :CREATE_CLAIMABLE_BALANCE_UNDERFUNDED
  ]

  describe "CreateClaimableBalanceResultCode" do
    setup do
      %{
        codes: @codes,
        result: CreateClaimableBalanceResultCode.new(:CREATE_CLAIMABLE_BALANCE_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %CreateClaimableBalanceResultCode{identifier: ^type} =
              CreateClaimableBalanceResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = CreateClaimableBalanceResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        CreateClaimableBalanceResultCode.encode_xdr(%CreateClaimableBalanceResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = CreateClaimableBalanceResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = CreateClaimableBalanceResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = CreateClaimableBalanceResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = CreateClaimableBalanceResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%CreateClaimableBalanceResultCode{identifier: :CREATE_CLAIMABLE_BALANCE_LOW_RESERVE}, ""} =
        CreateClaimableBalanceResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
