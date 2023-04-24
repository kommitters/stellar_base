defmodule StellarBase.XDR.SCContractExecutableTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCContractExecutableType

  @codes [
    :SCCONTRACT_EXECUTABLE_WASM_REF,
    :SCCONTRACT_EXECUTABLE_TOKEN
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>
  ]

  describe "SCContractExecutableType" do
    setup do
      %{
        codes: @codes,
        results: Enum.map(@codes, &SCContractExecutableType.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %SCContractExecutableType{identifier: ^type} = SCContractExecutableType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SCContractExecutableType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        SCContractExecutableType.encode_xdr(%SCContractExecutableType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SCContractExecutableType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SCContractExecutableType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SCContractExecutableType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SCContractExecutableType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%SCContractExecutableType{identifier: _}, ""} =
              SCContractExecutableType.decode_xdr!(binary)
    end
  end
end
