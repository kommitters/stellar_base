defmodule Stellar.XDR.Operations.AllowTrustResultTest do
  use ExUnit.Case

  alias Stellar.XDR.Void
  alias Stellar.XDR.Operations.{AllowTrustResult, AllowTrustResultCode}

  describe "AllowTrustResult" do
    setup do
      code = AllowTrustResultCode.new(:ALLOW_TRUST_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: AllowTrustResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %AllowTrustResult{code: ^code, result: ^value} = AllowTrustResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = AllowTrustResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = AllowTrustResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = AllowTrustResult.new("TEST", code)
      ^binary = AllowTrustResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = AllowTrustResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = AllowTrustResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%AllowTrustResult{
         code: %AllowTrustResultCode{identifier: :ALLOW_TRUST_NO_TRUST_LINE}
       }, ""} = AllowTrustResult.decode_xdr!(<<255, 255, 255, 254>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = AllowTrustResult.decode_xdr(123)
    end
  end
end
