defmodule StellarBase.XDR.ClaimantTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ClaimantType

  describe "ClaimantType" do
    setup do
      %{
        type: :CLAIMANT_TYPE_V0,
        revoke_type: ClaimantType.new(:CLAIMANT_TYPE_V0),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type} do
      %ClaimantType{identifier: ^type} = ClaimantType.new(type)
    end

    test "encode_xdr/1", %{revoke_type: revoke_type, binary: binary} do
      {:ok, ^binary} = ClaimantType.encode_xdr(revoke_type)
    end

    test "encode_xdr!/1", %{revoke_type: revoke_type, binary: binary} do
      ^binary = ClaimantType.encode_xdr!(revoke_type)
    end

    test "decode_xdr/2", %{revoke_type: revoke_type, binary: binary} do
      {:ok, {^revoke_type, ""}} = ClaimantType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimantType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_type: revoke_type, binary: binary} do
      {^revoke_type, ^binary} = ClaimantType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        ClaimantType.encode_xdr(%ClaimantType{
          identifier: SECRET_KEY_TYPE_ED25519
        })
    end
  end
end
