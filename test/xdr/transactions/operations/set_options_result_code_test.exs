defmodule StellarBase.XDR.Operations.SetOptionsResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.SetOptionsResultCode

  describe "SetOptionsResultCode" do
    setup do
      %{
        code: :SET_OPTIONS_SUCCESS,
        result: SetOptionsResultCode.new(:SET_OPTIONS_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %SetOptionsResultCode{identifier: ^type} = SetOptionsResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = SetOptionsResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        SetOptionsResultCode.encode_xdr(%SetOptionsResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = SetOptionsResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = SetOptionsResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SetOptionsResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = SetOptionsResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%SetOptionsResultCode{identifier: :SET_OPTIONS_TOO_MANY_SIGNERS}, ""} =
        SetOptionsResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
