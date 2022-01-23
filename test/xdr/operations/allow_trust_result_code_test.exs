defmodule StellarBase.XDR.Operations.AllowTrustResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.AllowTrustResultCode

  @codes [
    :ALLOW_TRUST_SUCCESS,
    :ALLOW_TRUST_MALFORMED,
    :ALLOW_TRUST_NO_TRUST_LINE,
    :ALLOW_TRUST_TRUST_NOT_REQUIRED,
    :ALLOW_TRUST_CANT_REVOKE,
    :ALLOW_TRUST_SELF_NOT_ALLOWED,
    :ALLOW_TRUST_LOW_RESERVE
  ]

  describe "AllowTrustResultCode" do
    setup do
      %{
        codes: @codes,
        result: AllowTrustResultCode.new(:ALLOW_TRUST_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %AllowTrustResultCode{identifier: ^type} = AllowTrustResultCode.new(type)
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
