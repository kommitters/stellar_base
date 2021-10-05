defmodule Stellar.XDR.RevokeSponsorshipTypeTest do
  use ExUnit.Case

  alias Stellar.XDR.RevokeSponsorshipType

  describe "LedgerEntry RevokeSponsorshipType" do
    setup do
      %{
        type: :REVOKE_SPONSORSHIP_LEDGER_ENTRY,
        revoke_type: RevokeSponsorshipType.new(:REVOKE_SPONSORSHIP_LEDGER_ENTRY),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type} do
      %RevokeSponsorshipType{identifier: ^type} = RevokeSponsorshipType.new(type)
    end

    test "encode_xdr/1", %{revoke_type: revoke_type, binary: binary} do
      {:ok, ^binary} = RevokeSponsorshipType.encode_xdr(revoke_type)
    end

    test "encode_xdr!/1", %{revoke_type: revoke_type, binary: binary} do
      ^binary = RevokeSponsorshipType.encode_xdr!(revoke_type)
    end

    test "decode_xdr/2", %{revoke_type: revoke_type, binary: binary} do
      {:ok, {^revoke_type, ""}} = RevokeSponsorshipType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RevokeSponsorshipType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_type: revoke_type, binary: binary} do
      {^revoke_type, ^binary} = RevokeSponsorshipType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        RevokeSponsorshipType.encode_xdr(%RevokeSponsorshipType{
          identifier: SECRET_KEY_TYPE_ED25519
        })
    end
  end

  describe "Signer RevokeSponsorshipType" do
    setup do
      %{
        type: :REVOKE_SPONSORSHIP_SIGNER,
        revoke_type: RevokeSponsorshipType.new(:REVOKE_SPONSORSHIP_SIGNER),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1", %{type: type} do
      %RevokeSponsorshipType{identifier: ^type} = RevokeSponsorshipType.new(type)
    end

    test "encode_xdr/1", %{revoke_type: revoke_type, binary: binary} do
      {:ok, ^binary} = RevokeSponsorshipType.encode_xdr(revoke_type)
    end

    test "encode_xdr!/1", %{revoke_type: revoke_type, binary: binary} do
      ^binary = RevokeSponsorshipType.encode_xdr!(revoke_type)
    end

    test "decode_xdr/2", %{revoke_type: revoke_type, binary: binary} do
      {:ok, {^revoke_type, ""}} = RevokeSponsorshipType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = RevokeSponsorshipType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_type: revoke_type, binary: binary} do
      {^revoke_type, ^binary} = RevokeSponsorshipType.decode_xdr!(binary <> binary)
    end
  end
end
