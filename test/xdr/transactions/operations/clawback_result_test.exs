defmodule StellarBase.XDR.ClawbackResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.{ClawbackResult, ClawbackResultCode}

  describe "ClawbackResult" do
    setup do
      code = ClawbackResultCode.new(:CLAWBACK_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: ClawbackResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %ClawbackResult{value: ^code, type: ^value} = ClawbackResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ClawbackResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ClawbackResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = ClawbackResult.new("TEST", code)
      ^binary = ClawbackResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ClawbackResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ClawbackResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%ClawbackResult{
         value: %ClawbackResultCode{identifier: :CLAWBACK_NOT_CLAWBACK_ENABLED}
       }, ""} = ClawbackResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClawbackResult.decode_xdr(123)
    end
  end
end
