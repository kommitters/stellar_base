defmodule StellarBase.XDR.Operations.EndSponsoringFutureReservesResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void

  alias StellarBase.XDR.Operations.{
    EndSponsoringFutureReservesResult,
    EndSponsoringFutureReservesResultCode
  }

  describe "EndSponsoringFutureReservesResult" do
    setup do
      code = EndSponsoringFutureReservesResultCode.new(:END_SPONSORING_FUTURE_RESERVES_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: EndSponsoringFutureReservesResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %EndSponsoringFutureReservesResult{code: ^code, result: ^value} =
        EndSponsoringFutureReservesResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = EndSponsoringFutureReservesResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = EndSponsoringFutureReservesResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = EndSponsoringFutureReservesResult.new("TEST", code)
      ^binary = EndSponsoringFutureReservesResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = EndSponsoringFutureReservesResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = EndSponsoringFutureReservesResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%EndSponsoringFutureReservesResult{
         code: %EndSponsoringFutureReservesResultCode{
           identifier: :END_SPONSORING_FUTURE_RESERVES_NOT_SPONSORED
         }
       }, ""} = EndSponsoringFutureReservesResult.decode_xdr!(<<255, 255, 255, 255>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = EndSponsoringFutureReservesResult.decode_xdr(123)
    end
  end
end
