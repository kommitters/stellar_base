defmodule Stellar.XDR.EnvelopeTypeTest do
  use ExUnit.Case

  alias Stellar.XDR.EnvelopeType

  describe "EnvelopeType" do
    setup do
      %{
        identifier: :ENVELOPE_TYPE_AUTH,
        envelope_type: EnvelopeType.new(:ENVELOPE_TYPE_AUTH),
        binary: <<0, 0, 0, 3>>
      }
    end

    test "new/1", %{identifier: type} do
      %EnvelopeType{identifier: ^type} = EnvelopeType.new(type)
    end

    test "new/1 with a default type" do
      %EnvelopeType{identifier: :ENVELOPE_TYPE_TX_V0} = EnvelopeType.new()
    end

    test "encode_xdr/1", %{envelope_type: envelope_type, binary: binary} do
      {:ok, ^binary} = EnvelopeType.encode_xdr(envelope_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} = EnvelopeType.encode_xdr(%EnvelopeType{identifier: MEMO_TEST})
    end

    test "encode_xdr!/1", %{envelope_type: envelope_type, binary: binary} do
      ^binary = EnvelopeType.encode_xdr!(envelope_type)
    end

    test "decode_xdr/2", %{envelope_type: envelope_type, binary: binary} do
      {:ok, {^envelope_type, ""}} = EnvelopeType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = EnvelopeType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{envelope_type: envelope_type, binary: binary} do
      {^envelope_type, ^binary} = EnvelopeType.decode_xdr!(binary <> binary)
    end
  end
end
