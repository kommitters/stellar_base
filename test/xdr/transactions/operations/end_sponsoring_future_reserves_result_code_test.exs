defmodule StellarBase.XDR.Operations.EndSponsoringFutureReservesResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.EndSponsoringFutureReservesResultCode

  @codes [
    :END_SPONSORING_FUTURE_RESERVES_SUCCESS,
    :END_SPONSORING_FUTURE_RESERVES_NOT_SPONSORED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>
  ]

  describe "EndSponsoringFutureReservesResultCode" do
    setup do
      %{
        codes: @codes,
        results:
          @codes |> Enum.map(fn code -> EndSponsoringFutureReservesResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %EndSponsoringFutureReservesResultCode{identifier: ^type} =
              EndSponsoringFutureReservesResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = EndSponsoringFutureReservesResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        EndSponsoringFutureReservesResultCode.encode_xdr(%EndSponsoringFutureReservesResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = EndSponsoringFutureReservesResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = EndSponsoringFutureReservesResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = EndSponsoringFutureReservesResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do:
            {^result, ^binary} =
              EndSponsoringFutureReservesResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%EndSponsoringFutureReservesResultCode{
               identifier: _
             }, ""} = EndSponsoringFutureReservesResultCode.decode_xdr!(binary)
    end
  end
end
