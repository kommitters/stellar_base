defmodule StellarBase.XDR.ClaimAtomTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ClaimAtomType

  describe "ClaimAtomType" do
    setup do
      %{
        identifier: :CLAIM_ATOM_TYPE_ORDER_BOOK,
        envelope_type: ClaimAtomType.new(:CLAIM_ATOM_TYPE_ORDER_BOOK),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1", %{identifier: type} do
      %ClaimAtomType{identifier: ^type} = ClaimAtomType.new(type)
    end

    test "new/1 with a default type" do
      %ClaimAtomType{identifier: :CLAIM_ATOM_TYPE_V0} = ClaimAtomType.new()
    end

    test "encode_xdr/1", %{envelope_type: envelope_type, binary: binary} do
      {:ok, ^binary} = ClaimAtomType.encode_xdr(envelope_type)
    end

    test "encode_xdr/1 with an invalid identifier" do
      {:error, :invalid_key} = ClaimAtomType.encode_xdr(%ClaimAtomType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{envelope_type: envelope_type, binary: binary} do
      ^binary = ClaimAtomType.encode_xdr!(envelope_type)
    end

    test "decode_xdr/2", %{envelope_type: envelope_type, binary: binary} do
      {:ok, {^envelope_type, ""}} = ClaimAtomType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ClaimAtomType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{envelope_type: envelope_type, binary: binary} do
      {^envelope_type, ^binary} = ClaimAtomType.decode_xdr!(binary <> binary)
    end
  end
end
