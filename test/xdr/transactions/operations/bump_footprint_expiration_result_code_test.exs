defmodule StellarBase.XDR.Operations.BumpFootprintExpirationResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.BumpFootprintExpirationResultCode

  @codes [
    :BUMP_FOOTPRINT_EXPIRATION_SUCCESS,
    :BUMP_FOOTPRINT_EXPIRATION_MALFORMED,
    :BUMP_FOOTPRINT_EXPIRATION_RESOURCE_LIMIT_EXCEEDED
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>
  ]

  describe "BumpFootprintExpirationResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> BumpFootprintExpirationResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do:
            %BumpFootprintExpirationResultCode{identifier: ^type} =
              BumpFootprintExpirationResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = BumpFootprintExpirationResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        BumpFootprintExpirationResultCode.encode_xdr(%BumpFootprintExpirationResultCode{
          identifier: :TEST
        })
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = BumpFootprintExpirationResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = BumpFootprintExpirationResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = BumpFootprintExpirationResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = BumpFootprintExpirationResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%BumpFootprintExpirationResultCode{identifier: _}, ""} =
              BumpFootprintExpirationResultCode.decode_xdr!(binary)
    end
  end
end
