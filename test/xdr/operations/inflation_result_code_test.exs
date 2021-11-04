defmodule StellarBase.XDR.Operations.InflationResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.InflationResultCode

  describe "InflationResultCode" do
    setup do
      %{
        code: :INFLATION_SUCCESS,
        result: InflationResultCode.new(:INFLATION_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %InflationResultCode{identifier: ^type} = InflationResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = InflationResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        InflationResultCode.encode_xdr(%InflationResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = InflationResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = InflationResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = InflationResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = InflationResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%InflationResultCode{identifier: :INFLATION_NOT_TIME}, ""} =
        InflationResultCode.decode_xdr!(<<255, 255, 255, 255>>)
    end
  end
end
