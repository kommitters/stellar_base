defmodule StellarBase.XDR.Operations.RestoreFootprintResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.Operations.{RestoreFootprintResult, RestoreFootprintResultCode}

  describe "RestoreFootprintResult" do
    setup do
      type = RestoreFootprintResultCode.new(:RESTORE_FOOTPRINT_SUCCESS)

      %{
        type: type,
        value: Void.new(),
        result: RestoreFootprintResult.new(Void.new(), type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type, value: value} do
      %RestoreFootprintResult{type: ^type, value: ^value} =
        RestoreFootprintResult.new(value, type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = RestoreFootprintResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = RestoreFootprintResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{type: type, binary: binary} do
      result = RestoreFootprintResult.new("TEST", type)
      ^binary = RestoreFootprintResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = RestoreFootprintResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = RestoreFootprintResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error type" do
      {%RestoreFootprintResult{
         type: %RestoreFootprintResultCode{identifier: :RESTORE_FOOTPRINT_MALFORMED}
       }, ""} = RestoreFootprintResult.decode_xdr!(<<255, 255, 255, 255>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RestoreFootprintResult.decode_xdr(123)
    end
  end
end
