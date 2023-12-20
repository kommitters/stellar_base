defmodule StellarBase.XDR.Operations.ExtendFootprintTTLResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void

  alias StellarBase.XDR.Operations.{
    ExtendFootprintTTLResult,
    ExtendFootprintTTLResultCode
  }

  describe "ExtendFootprintTTLResult" do
    setup do
      type = ExtendFootprintTTLResultCode.new(:EXTEND_FOOTPRINT_TTL_SUCCESS)

      %{
        type: type,
        value: Void.new(),
        result: ExtendFootprintTTLResult.new(Void.new(), type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type, value: value} do
      %ExtendFootprintTTLResult{type: ^type, value: ^value} =
        ExtendFootprintTTLResult.new(value, type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ExtendFootprintTTLResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ExtendFootprintTTLResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{type: type, binary: binary} do
      result = ExtendFootprintTTLResult.new("TEST", type)
      ^binary = ExtendFootprintTTLResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ExtendFootprintTTLResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ExtendFootprintTTLResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error type" do
      {%ExtendFootprintTTLResult{
         type: %ExtendFootprintTTLResultCode{
           identifier: :EXTEND_FOOTPRINT_TTL_MALFORMED
         }
       }, ""} = ExtendFootprintTTLResult.decode_xdr!(<<255, 255, 255, 255>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ExtendFootprintTTLResult.decode_xdr(123)
    end
  end
end
