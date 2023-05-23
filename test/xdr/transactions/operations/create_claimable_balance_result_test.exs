defmodule StellarBase.XDR.CreateClaimableBalanceResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ClaimableBalanceID, ClaimableBalanceIDType, Hash}

  alias StellarBase.XDR.{
    CreateClaimableBalanceResult,
    CreateClaimableBalanceResultCode,
    Void
  }

  describe "CreateClaimableBalanceResult" do
    setup do
      code = CreateClaimableBalanceResultCode.new(:CREATE_CLAIMABLE_BALANCE_SUCCESS)

      value =
        "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
        |> Hash.new()
        |> ClaimableBalanceID.new(ClaimableBalanceIDType.new(:CLAIMABLE_BALANCE_ID_TYPE_V0))

      %{
        code: code,
        value: value,
        result: CreateClaimableBalanceResult.new(value, code),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83,
            52, 85, 80, 54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %CreateClaimableBalanceResult{value: ^value, type: ^code} =
        CreateClaimableBalanceResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = CreateClaimableBalanceResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = CreateClaimableBalanceResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value" do
      code = CreateClaimableBalanceResultCode.new(:CREATE_CLAIMABLE_BALANCE_LOW_RESERVE)

      <<255, 255, 255, 254>> =
        "TEST"
        |> CreateClaimableBalanceResult.new(code)
        |> CreateClaimableBalanceResult.encode_xdr!()
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = CreateClaimableBalanceResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = CreateClaimableBalanceResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%CreateClaimableBalanceResult{
         value: %Void{value: nil},
         type: %CreateClaimableBalanceResultCode{
           identifier: :CREATE_CLAIMABLE_BALANCE_LOW_RESERVE
         }
       }, ""} = CreateClaimableBalanceResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreateClaimableBalanceResult.decode_xdr(123)
    end
  end
end
