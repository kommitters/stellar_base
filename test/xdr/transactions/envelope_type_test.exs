defmodule StellarBase.XDR.EnvelopeTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.EnvelopeType

  @types [
    :ENVELOPE_TYPE_TX_V0,
    :ENVELOPE_TYPE_SCP,
    :ENVELOPE_TYPE_TX,
    :ENVELOPE_TYPE_AUTH,
    :ENVELOPE_TYPE_SCPVALUE,
    :ENVELOPE_TYPE_TX_FEE_BUMP,
    :ENVELOPE_TYPE_OP_ID,
    :ENVELOPE_TYPE_POOL_REVOKE_OP_ID,
    :ENVELOPE_TYPE_CONTRACT_ID,
    :ENVELOPE_TYPE_SOROBAN_AUTHORIZATION
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

  describe "EnvelopeType" do
    setup do
      %{
        types: @types,
        results: Enum.map(@types, &EnvelopeType.new/1),
        binaries: @binaries
      }
    end

    test "new/1", %{types: types} do
      for type <- types,
          do: %EnvelopeType{identifier: ^type} = EnvelopeType.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = EnvelopeType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid type" do
      {:error, :invalid_key} = EnvelopeType.encode_xdr(%EnvelopeType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = EnvelopeType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = EnvelopeType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = EnvelopeType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = EnvelopeType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error type", %{binaries: binaries} do
      for binary <- binaries,
          do: {%EnvelopeType{identifier: _}, ""} = EnvelopeType.decode_xdr!(binary)
    end
  end
end
