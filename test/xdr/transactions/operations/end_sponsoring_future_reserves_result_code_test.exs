defmodule StellarBase.XDR.Operations.EndSponsoringFutureReservesResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.EndSponsoringFutureReservesResultCode

  describe "EndSponsoringFutureReservesResultCode" do
    setup do
      %{
        code: :END_SPONSORING_FUTURE_RESERVES_SUCCESS,
        result:
          EndSponsoringFutureReservesResultCode.new(:END_SPONSORING_FUTURE_RESERVES_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %EndSponsoringFutureReservesResultCode{identifier: ^type} =
        EndSponsoringFutureReservesResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = EndSponsoringFutureReservesResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        EndSponsoringFutureReservesResultCode.encode_xdr(%EndSponsoringFutureReservesResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = EndSponsoringFutureReservesResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = EndSponsoringFutureReservesResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = EndSponsoringFutureReservesResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = EndSponsoringFutureReservesResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%EndSponsoringFutureReservesResultCode{
         identifier: :END_SPONSORING_FUTURE_RESERVES_NOT_SPONSORED
       }, ""} = EndSponsoringFutureReservesResultCode.decode_xdr!(<<255, 255, 255, 255>>)
    end
  end
end
