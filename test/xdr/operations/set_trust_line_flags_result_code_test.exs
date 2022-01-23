defmodule StellarBase.XDR.Operations.SetTrustLineFlagsResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.SetTrustLineFlagsResultCode

  @codes [
    :SET_TRUST_LINE_FLAGS_SUCCESS,
    :SET_TRUST_LINE_FLAGS_MALFORMED,
    :SET_TRUST_LINE_FLAGS_NO_TRUST_LINE,
    :SET_TRUST_LINE_FLAGS_CANT_REVOKE,
    :SET_TRUST_LINE_FLAGS_INVALID_STATE,
    :SET_TRUST_LINE_FLAGS_LOW_RESERVE
  ]

  describe "SetTrustLineFlagsResultCode" do
    setup do
      %{
        codes: @codes,
        result: SetTrustLineFlagsResultCode.new(:SET_TRUST_LINE_FLAGS_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %SetTrustLineFlagsResultCode{identifier: ^type} =
              SetTrustLineFlagsResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = SetTrustLineFlagsResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        SetTrustLineFlagsResultCode.encode_xdr(%SetTrustLineFlagsResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = SetTrustLineFlagsResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = SetTrustLineFlagsResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SetTrustLineFlagsResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = SetTrustLineFlagsResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%SetTrustLineFlagsResultCode{identifier: :SET_TRUST_LINE_FLAGS_NO_TRUST_LINE}, ""} =
        SetTrustLineFlagsResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
