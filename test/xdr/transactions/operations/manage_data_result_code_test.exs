defmodule StellarBase.XDR.Operations.ManageDataResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.ManageDataResultCode

  @codes [
    :MANAGE_DATA_SUCCESS,
    :MANAGE_DATA_NOT_SUPPORTED_YET,
    :MANAGE_DATA_NAME_NOT_FOUND,
    :MANAGE_DATA_LOW_RESERVE,
    :MANAGE_DATA_INVALID_NAME
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>
  ]

  describe "ManageDataResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> ManageDataResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %ManageDataResultCode{identifier: ^type} = ManageDataResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = ManageDataResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        ManageDataResultCode.encode_xdr(%ManageDataResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = ManageDataResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = ManageDataResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ManageDataResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = ManageDataResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%ManageDataResultCode{identifier: _}, ""} = ManageDataResultCode.decode_xdr!(binary)
    end
  end
end
