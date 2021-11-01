defmodule Stellar.XDR.Operations.ClawbackClaimableBalanceResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.ClawbackClaimableBalanceResultCode

  describe "ClawbackClaimableBalanceResultCode" do
    setup do
      %{
        code: :CLAWBACK_CLAIMABLE_BALANCE_SUCCESS,
        result: ClawbackClaimableBalanceResultCode.new(:CLAWBACK_CLAIMABLE_BALANCE_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %ClawbackClaimableBalanceResultCode{identifier: ^type} =
        ClawbackClaimableBalanceResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ClawbackClaimableBalanceResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ClawbackClaimableBalanceResultCode.encode_xdr(%ClawbackClaimableBalanceResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ClawbackClaimableBalanceResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ClawbackClaimableBalanceResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClawbackClaimableBalanceResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ClawbackClaimableBalanceResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%ClawbackClaimableBalanceResultCode{identifier: :CLAWBACK_CLAIMABLE_BALANCE_NOT_ISSUER},
       ""} = ClawbackClaimableBalanceResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
