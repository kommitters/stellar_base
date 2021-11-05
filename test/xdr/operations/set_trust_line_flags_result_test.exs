defmodule StellarBase.XDR.Operations.SetTrustLineFlagsResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.Operations.{SetTrustLineFlagsResult, SetTrustLineFlagsResultCode}

  describe "SetTrustLineFlagsResult" do
    setup do
      code = SetTrustLineFlagsResultCode.new(:SET_TRUST_LINE_FLAGS_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: SetTrustLineFlagsResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %SetTrustLineFlagsResult{code: ^code, result: ^value} =
        SetTrustLineFlagsResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = SetTrustLineFlagsResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = SetTrustLineFlagsResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = SetTrustLineFlagsResult.new("TEST", code)
      ^binary = SetTrustLineFlagsResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = SetTrustLineFlagsResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = SetTrustLineFlagsResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%SetTrustLineFlagsResult{
         code: %SetTrustLineFlagsResultCode{identifier: :SET_TRUST_LINE_FLAGS_NO_TRUST_LINE}
       }, ""} = SetTrustLineFlagsResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = SetTrustLineFlagsResult.decode_xdr(123)
    end
  end
end
