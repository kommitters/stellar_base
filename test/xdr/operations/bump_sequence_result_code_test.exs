defmodule Stellar.XDR.Operations.BumpSequenceResultCodeTest do
  use ExUnit.Case

  alias Stellar.XDR.Operations.BumpSequenceResultCode

  describe "BumpSequenceResultCode" do
    setup do
      %{
        code: :BUMP_SEQUENCE_SUCCESS,
        result: BumpSequenceResultCode.new(:BUMP_SEQUENCE_SUCCESS),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{code: type} do
      %BumpSequenceResultCode{identifier: ^type} = BumpSequenceResultCode.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = BumpSequenceResultCode.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid code" do
      {:error, :invalid_key} =
        BumpSequenceResultCode.encode_xdr(%BumpSequenceResultCode{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = BumpSequenceResultCode.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = BumpSequenceResultCode.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = BumpSequenceResultCode.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = BumpSequenceResultCode.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error code" do
      {%BumpSequenceResultCode{identifier: :BUMP_SEQUENCE_BAD_SEQ}, ""} =
        BumpSequenceResultCode.decode_xdr!(<<255, 255, 255, 255>>)
    end
  end
end
