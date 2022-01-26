defmodule StellarBase.XDR.Operations.BumpSequenceResultCodeTest do
  use ExUnit.Case

  alias StellarBase.XDR.Operations.BumpSequenceResultCode

  @codes [
    :BUMP_SEQUENCE_SUCCESS,
    :BUMP_SEQUENCE_BAD_SEQ
  ]

  @binaries [
    <<0, 0, 0, 0>>,
    <<255, 255, 255, 255>>
  ]

  describe "BumpSequenceResultCode" do
    setup do
      %{
        codes: @codes,
        results: @codes |> Enum.map(fn code -> BumpSequenceResultCode.new(code) end),
        binaries: @binaries
      }
    end

    test "new/1", %{codes: types} do
      for type <- types,
          do: %BumpSequenceResultCode{identifier: ^type} = BumpSequenceResultCode.new(type)
    end

    test "encode_xdr/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, ^binary} = BumpSequenceResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        BumpSequenceResultCode.encode_xdr(%BumpSequenceResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: ^binary = BumpSequenceResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {:ok, {^result, ""}} = BumpSequenceResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = BumpSequenceResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{results: results, binaries: binaries} do
      for {result, binary} <- Enum.zip(results, binaries),
          do: {^result, ^binary} = BumpSequenceResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code", %{binaries: binaries} do
      for binary <- binaries,
          do:
            {%BumpSequenceResultCode{identifier: _}, ""} =
              BumpSequenceResultCode.decode_xdr!(binary)
    end
  end
end
