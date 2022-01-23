defmodule StellarBase.XDR.Operations.BeginSponsoringFutureReservesResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.BeginSponsoringFutureReservesResultCode

  @codes [
    :BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS,
    :BEGIN_SPONSORING_FUTURE_RESERVES_MALFORMED,
    :BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED,
    :BEGIN_SPONSORING_FUTURE_RESERVES_RECURSIVE
  ]

  describe "BeginSponsoringFutureReservesResultCode" do
    setup do
      %{
        codes: @codes,
        result:
          BeginSponsoringFutureReservesResultCode.new(:BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %BeginSponsoringFutureReservesResultCode{identifier: ^type} =
              BeginSponsoringFutureReservesResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = BeginSponsoringFutureReservesResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        BeginSponsoringFutureReservesResultCode.encode_xdr(
          %BeginSponsoringFutureReservesResultCode{
            identifier: :TEST
          }
        )
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = BeginSponsoringFutureReservesResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = BeginSponsoringFutureReservesResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = BeginSponsoringFutureReservesResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = BeginSponsoringFutureReservesResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%BeginSponsoringFutureReservesResultCode{
         identifier: :BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED
       }, ""} = BeginSponsoringFutureReservesResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
