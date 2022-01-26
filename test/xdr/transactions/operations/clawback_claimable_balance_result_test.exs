defmodule StellarBase.XDR.Operations.ClawbackClaimableBalanceResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void

  alias StellarBase.XDR.Operations.{
    ClawbackClaimableBalanceResult,
    ClawbackClaimableBalanceResultCode
  }

  describe "ClawbackClaimableBalanceResult" do
    setup do
      code = ClawbackClaimableBalanceResultCode.new(:CLAWBACK_CLAIMABLE_BALANCE_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: ClawbackClaimableBalanceResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %ClawbackClaimableBalanceResult{code: ^code, result: ^value} =
        ClawbackClaimableBalanceResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ClawbackClaimableBalanceResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ClawbackClaimableBalanceResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = ClawbackClaimableBalanceResult.new("TEST", code)
      ^binary = ClawbackClaimableBalanceResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ClawbackClaimableBalanceResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ClawbackClaimableBalanceResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%ClawbackClaimableBalanceResult{
         code: %ClawbackClaimableBalanceResultCode{
           identifier: :CLAWBACK_CLAIMABLE_BALANCE_NOT_ISSUER
         }
       }, ""} = ClawbackClaimableBalanceResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClawbackClaimableBalanceResult.decode_xdr(123)
    end
  end
end
