defmodule StellarBase.XDR.Operations.BumpFootprintExpirationResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void

  alias StellarBase.XDR.Operations.{
    BumpFootprintExpirationResult,
    BumpFootprintExpirationResultCode
  }

  describe "BumpFootprintExpirationResult" do
    setup do
      type = BumpFootprintExpirationResultCode.new(:BUMP_FOOTPRINT_EXPIRATION_SUCCESS)

      %{
        type: type,
        value: Void.new(),
        result: BumpFootprintExpirationResult.new(Void.new(), type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type, value: value} do
      %BumpFootprintExpirationResult{type: ^type, value: ^value} =
        BumpFootprintExpirationResult.new(value, type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = BumpFootprintExpirationResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = BumpFootprintExpirationResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{type: type, binary: binary} do
      result = BumpFootprintExpirationResult.new("TEST", type)
      ^binary = BumpFootprintExpirationResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = BumpFootprintExpirationResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = BumpFootprintExpirationResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error type" do
      {%BumpFootprintExpirationResult{
         type: %BumpFootprintExpirationResultCode{
           identifier: :BUMP_FOOTPRINT_EXPIRATION_MALFORMED
         }
       }, ""} = BumpFootprintExpirationResult.decode_xdr!(<<255, 255, 255, 255>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = BumpFootprintExpirationResult.decode_xdr(123)
    end
  end
end
