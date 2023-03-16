defmodule StellarBase.XDR.SCAddressTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCAddressType

  @codes [
    :SC_ADDRESS_TYPE_ACCOUNT,
    :SC_ADDRESS_TYPE_CONTRACT
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>
  ]

  describe "SCAddressType" do
    setup do
      %{
        codes: @codes,
        results: Enum.map(@codes, &SCAddressType.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %SCAddressType{identifier: ^type} = SCAddressType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SCAddressType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} = SCAddressType.encode_xdr(%SCAddressType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SCAddressType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SCAddressType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SCAddressType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SCAddressType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%SCAddressType{identifier: _}, ""} = SCAddressType.decode_xdr!(binary)
    end
  end
end
