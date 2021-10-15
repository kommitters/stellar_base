defmodule Stellar.XDR.Operations.ChangeTrustResultTest do
  use ExUnit.Case

  alias Stellar.XDR.Void
  alias Stellar.XDR.Operations.{ChangeTrustResult, ChangeTrustResultCode}

  describe "ChangeTrustResult" do
    setup do
      code = ChangeTrustResultCode.new(:CHANGE_TRUST_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: ChangeTrustResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %ChangeTrustResult{code: ^code, result: ^value} = ChangeTrustResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ChangeTrustResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ChangeTrustResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = ChangeTrustResult.new("TEST", code)
      ^binary = ChangeTrustResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ChangeTrustResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ChangeTrustResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%ChangeTrustResult{
         code: %ChangeTrustResultCode{identifier: :CHANGE_TRUST_NO_ISSUER}
       }, ""} = ChangeTrustResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ChangeTrustResult.decode_xdr(123)
    end
  end
end
