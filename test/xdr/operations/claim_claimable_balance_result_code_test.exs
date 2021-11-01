defmodule Stellar.XDR.Operations.ClaimClaimableBalanceResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.ClaimClaimableBalanceResultCode

  describe "ClaimClaimableBalanceResultCode" do
    setup do
      %{
        code: :CLAIM_CLAIMABLE_BALANCE_SUCCESS,
        result: ClaimClaimableBalanceResultCode.new(:CLAIM_CLAIMABLE_BALANCE_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %ClaimClaimableBalanceResultCode{identifier: ^type} =
        ClaimClaimableBalanceResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ClaimClaimableBalanceResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ClaimClaimableBalanceResultCode.encode_xdr(%ClaimClaimableBalanceResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ClaimClaimableBalanceResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ClaimClaimableBalanceResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClaimClaimableBalanceResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ClaimClaimableBalanceResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%ClaimClaimableBalanceResultCode{identifier: :CLAIM_CLAIMABLE_BALANCE_CANNOT_CLAIM}, ""} =
        ClaimClaimableBalanceResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
