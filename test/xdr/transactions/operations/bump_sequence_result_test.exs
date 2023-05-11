defmodule StellarBase.XDR.BumpSequenceResultTest do
  use ExUnit.Case

  alias StellarBase.XDR.Void
  alias StellarBase.XDR.{BumpSequenceResult, BumpSequenceResultCode}

  describe "BumpSequenceResult" do
    setup do
      code = BumpSequenceResultCode.new(:BUMP_SEQUENCE_SUCCESS)

      %{
        code: code,
        value: Void.new(),
        result: BumpSequenceResult.new(Void.new(), code),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: code, value: value} do
      %BumpSequenceResult{value: ^code, type: ^value} = BumpSequenceResult.new(value, code)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = BumpSequenceResult.encode_xdr(result)
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = BumpSequenceResult.encode_xdr!(result)
    end

    test "encode_xdr!/1 with a default value", %{code: code, binary: binary} do
      result = BumpSequenceResult.new("TEST", code)
      ^binary = BumpSequenceResult.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = BumpSequenceResult.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = BumpSequenceResult.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 an error code" do
      {%BumpSequenceResult{
        value: %BumpSequenceResultCode{identifier: :BUMP_SEQUENCE_BAD_SEQ}
       }, ""} = BumpSequenceResult.decode_xdr!(<<255, 255, 255, 255>>)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = BumpSequenceResult.decode_xdr(123)
    end
  end
end
