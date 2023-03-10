defmodule StellarBase.XDR.SCObjectTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.SCObjectType

  @codes [
    :SCO_VEC,
    :SCO_MAP,
    :SCO_U64,
    :SCO_I64,
    :SCO_U128,
    :SCO_I128,
    :SCO_BYTES,
    :SCO_CONTRACT_CODE,
    :SCO_ADDRESS,
    :SCO_NONCE_KEY
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<0, 0, 0, 1>>,
    <<0, 0, 0, 2>>,
    <<0, 0, 0, 3>>,
    <<0, 0, 0, 4>>,
    <<0, 0, 0, 5>>,
    <<0, 0, 0, 6>>,
    <<0, 0, 0, 7>>,
    <<0, 0, 0, 8>>,
    <<0, 0, 0, 9>>
  ]

  describe "SCObjectType" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> SCObjectType.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %SCObjectType{identifier: ^type} = SCObjectType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = SCObjectType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} = SCObjectType.encode_xdr(%SCObjectType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = SCObjectType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = SCObjectType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = SCObjectType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = SCObjectType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do: {%SCObjectType{identifier: _}, ""} = SCObjectType.decode_xdr!(binary)
    end
  end
end
