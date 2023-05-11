defmodule StellarBase.XDR.BeginSponsoringFutureReservesResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.BeginSponsoringFutureReservesResultCode

  @codes [
    :BEGIN_SPONSORING_FUTURE_RESERVES_SUCCESS,
    :BEGIN_SPONSORING_FUTURE_RESERVES_MALFORMED,
    :BEGIN_SPONSORING_FUTURE_RESERVES_ALREADY_SPONSORED,
    :BEGIN_SPONSORING_FUTURE_RESERVES_RECURSIVE
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>
  ]

  describe "BeginSponsoringFutureReservesResultCode" do
    setup do
      %{
        codes: @codes,
        results:
          @codes |> Enum.map(fn code -> BeginSponsoringFutureReservesResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %BeginSponsoringFutureReservesResultCode{identifier: ^type} =
              BeginSponsoringFutureReservesResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = BeginSponsoringFutureReservesResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        BeginSponsoringFutureReservesResultCode.encode_xdr(
          %BeginSponsoringFutureReservesResultCode{
            identifier: :TEST
          }
        )
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = BeginSponsoringFutureReservesResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = BeginSponsoringFutureReservesResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = BeginSponsoringFutureReservesResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do:
            {^result, ^binary} =
              BeginSponsoringFutureReservesResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%BeginSponsoringFutureReservesResultCode{
               identifier: _
             }, ""} = BeginSponsoringFutureReservesResultCode.decode_xdr!(binary)
    end
  end
end
