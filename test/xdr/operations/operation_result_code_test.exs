defmodule StellarBase.XDR.OperationResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.OperationResultCode

  @codes [
    :opINNER,
    :opBAD_AUTH,
    :opNO_ACCOUNT,
    :opNOT_SUPPORTED,
    :opTOO_MANY_SUBENTRIES,
    :opEXCEEDED_WORK_LIMIT,
    :opTOO_MANY_SPONSORING
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>,
    <<255, 255, 255, 254>>,
    <<255, 255, 255, 253>>,
    <<255, 255, 255, 252>>,
    <<255, 255, 255, 251>>,
    <<255, 255, 255, 250>>
  ]

  describe "OperationResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> OperationResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %OperationResultCode{identifier: ^type} = OperationResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = OperationResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        OperationResultCode.encode_xdr(%OperationResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = OperationResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = OperationResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = OperationResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = OperationResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%OperationResultCode{identifier: _}, ""} = OperationResultCode.decode_xdr!(binary)
    end
  end
end
