defmodule Stellar.XDR.Operations.ClaimClaimableBalanceResultTest do
  use ExUnit.Case

  alias Stellar.XDR.Void
  alias Stellar.XDR.Operations.{ClaimClaimableBalanceResult, ClaimClaimableBalanceResultCode}

  describe "ClaimClaimableBalanceResult" do
    setup do
      code = ClaimClaimableBalanceResultCode.new(:CLAIM_CLAIMABLE_BALANCE_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: ClaimClaimableBalanceResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %ClaimClaimableBalanceResult{code: ^code, result: ^value} =
        ClaimClaimableBalanceResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ClaimClaimableBalanceResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ClaimClaimableBalanceResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = ClaimClaimableBalanceResult.new("TEST", code)
      ^binary = ClaimClaimableBalanceResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ClaimClaimableBalanceResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ClaimClaimableBalanceResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%ClaimClaimableBalanceResult{
         code: %ClaimClaimableBalanceResultCode{identifier: :CLAIM_CLAIMABLE_BALANCE_CANNOT_CLAIM}
       }, ""} = ClaimClaimableBalanceResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimClaimableBalanceResult.decode_xdr(123)
    end
  end
end
