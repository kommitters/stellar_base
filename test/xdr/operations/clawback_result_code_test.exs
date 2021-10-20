defmodule Stellar.XDR.Operations.ClawbackResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.ClawbackResultCode

  describe "ClawbackResultCode" do
    setup do
      %{
        code: :CLAWBACK_SUCCESS,
        result: ClawbackResultCode.new(:CLAWBACK_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %ClawbackResultCode{identifier: ^type} = ClawbackResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ClawbackResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ClawbackResultCode.encode_xdr(%ClawbackResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ClawbackResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ClawbackResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClawbackResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ClawbackResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%ClawbackResultCode{identifier: :CLAWBACK_NOT_CLAWBACK_ENABLED}, ""} =
        ClawbackResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
