defmodule StellarBase.XDR.SCContractCodeTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCContractCodeType

  @codes [
    :SCCONTRACT_CODE_WASM_REF,
    :SCCONTRACT_CODE_TOKEN
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>
  ]

  describe "SCContractCodeType" do
    setup do
      %{
        codes: @codes,
        results: Enum.map(@codes, &SCContractCodeType.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %SCContractCodeType{identifier: ^type} = SCContractCodeType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SCContractCodeType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        SCContractCodeType.encode_xdr(%SCContractCodeType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SCContractCodeType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SCContractCodeType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SCContractCodeType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SCContractCodeType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%SCContractCodeType{identifier: _}, ""} = SCContractCodeType.decode_xdr!(binary)
    end
  end
end
