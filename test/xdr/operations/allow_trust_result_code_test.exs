defmodule Stellar.XDR.Operations.AllowTrustResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.AllowTrustResultCode

  describe "AllowTrustResultCode" do
    setup do
      %{
        code: :ALLOW_TRUST_SUCCESS,
        result: AllowTrustResultCode.new(:ALLOW_TRUST_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %AllowTrustResultCode{identifier: ^type} = AllowTrustResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = AllowTrustResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        AllowTrustResultCode.encode_xdr(%AllowTrustResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = AllowTrustResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = AllowTrustResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = AllowTrustResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = AllowTrustResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%AllowTrustResultCode{identifier: :ALLOW_TRUST_NO_TRUST_LINE}, ""} =
        AllowTrustResultCode.decode_xdr!(<<255, 255, 255, 254>>)
    end
  end
end
