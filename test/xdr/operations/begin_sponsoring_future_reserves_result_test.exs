defmodule StellarBase.XDR.Operations.BeginSponsoringFutureReservesResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void

  alias StellarBase.XDR.Operations.{
    BeginSponsoringFutureReservesResult,
    BeginSponsoringFutureReservesResultCode
  }

  describe "BeginSponsoringFutureReservesResult" do
    setup do
      code =
        BeginSponsoringFutureReservesResultCode.new(:BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: BeginSponsoringFutureReservesResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %BeginSponsoringFutureReservesResult{code: ^code, result: ^value} =
        BeginSponsoringFutureReservesResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = BeginSponsoringFutureReservesResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = BeginSponsoringFutureReservesResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = BeginSponsoringFutureReservesResult.new("TEST", code)
      ^binary = BeginSponsoringFutureReservesResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = BeginSponsoringFutureReservesResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = BeginSponsoringFutureReservesResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%BeginSponsoringFutureReservesResult{
         code: %BeginSponsoringFutureReservesResultCode{
           identifier: :BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED
         }
       }, ""} = BeginSponsoringFutureReservesResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = BeginSponsoringFutureReservesResult.decode_xdr(123)
    end
  end
end
