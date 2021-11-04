defmodule StellarBase.XDR.ClaimPredicateTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ClaimPredicateType

  describe "Unconditional ClaimPredicateType" do
    setup do
      %{
        type: :CLAIM_PREDICATE_UNCONDITIONAL,
        revoke_type: ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type} do
      %ClaimPredicateType{identifier: ^type} = ClaimPredicateType.new(type)
    end

    test "encode_xdr/1", %{revoke_type: revoke_type, binary: binary} do
      {:ok, ^binary} = ClaimPredicateType.encode_xdr(revoke_type)
    end

    test "encode_xdr!/1", %{revoke_type: revoke_type, binary: binary} do
      ^binary = ClaimPredicateType.encode_xdr!(revoke_type)
    end

    test "decode_xdr/2", %{revoke_type: revoke_type, binary: binary} do
      {:ok, {^revoke_type, ""}} = ClaimPredicateType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicateType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_type: revoke_type, binary: binary} do
      {^revoke_type, ^binary} = ClaimPredicateType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        ClaimPredicateType.encode_xdr(%ClaimPredicateType{
          identifier: SECRET_KEY_TYPE_ED25519
        })
    end
  end

  describe "AND ClaimPredicateType" do
    setup do
      %{
        type: :CLAIM_PREDICATE_AND,
        revoke_type: ClaimPredicateType.new(:CLAIM_PREDICATE_AND),
        binary: <<0, 0, 0, 1>>
      }
    end

    test "new/1", %{type: type} do
      %ClaimPredicateType{identifier: ^type} = ClaimPredicateType.new(type)
    end

    test "encode_xdr/1", %{revoke_type: revoke_type, binary: binary} do
      {:ok, ^binary} = ClaimPredicateType.encode_xdr(revoke_type)
    end

    test "encode_xdr!/1", %{revoke_type: revoke_type, binary: binary} do
      ^binary = ClaimPredicateType.encode_xdr!(revoke_type)
    end

    test "decode_xdr/2", %{revoke_type: revoke_type, binary: binary} do
      {:ok, {^revoke_type, ""}} = ClaimPredicateType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicateType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_type: revoke_type, binary: binary} do
      {^revoke_type, ^binary} = ClaimPredicateType.decode_xdr!(binary <> binary)
    end
  end

  describe "OR ClaimPredicateType" do
    setup do
      %{
        type: :CLAIM_PREDICATE_OR,
        revoke_type: ClaimPredicateType.new(:CLAIM_PREDICATE_OR),
        binary: <<0, 0, 0, 2>>
      }
    end

    test "new/1", %{type: type} do
      %ClaimPredicateType{identifier: ^type} = ClaimPredicateType.new(type)
    end

    test "encode_xdr/1", %{revoke_type: revoke_type, binary: binary} do
      {:ok, ^binary} = ClaimPredicateType.encode_xdr(revoke_type)
    end

    test "encode_xdr!/1", %{revoke_type: revoke_type, binary: binary} do
      ^binary = ClaimPredicateType.encode_xdr!(revoke_type)
    end

    test "decode_xdr/2", %{revoke_type: revoke_type, binary: binary} do
      {:ok, {^revoke_type, ""}} = ClaimPredicateType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicateType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_type: revoke_type, binary: binary} do
      {^revoke_type, ^binary} = ClaimPredicateType.decode_xdr!(binary <> binary)
    end
  end

  describe "Time ClaimPredicateType" do
    setup do
      %{
        type: :CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME,
        revoke_type: ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME),
        binary: <<0, 0, 0, 4>>
      }
    end

    test "new/1", %{type: type} do
      %ClaimPredicateType{identifier: ^type} = ClaimPredicateType.new(type)
    end

    test "encode_xdr/1", %{revoke_type: revoke_type, binary: binary} do
      {:ok, ^binary} = ClaimPredicateType.encode_xdr(revoke_type)
    end

    test "encode_xdr!/1", %{revoke_type: revoke_type, binary: binary} do
      ^binary = ClaimPredicateType.encode_xdr!(revoke_type)
    end

    test "decode_xdr/2", %{revoke_type: revoke_type, binary: binary} do
      {:ok, {^revoke_type, ""}} = ClaimPredicateType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicateType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{revoke_type: revoke_type, binary: binary} do
      {^revoke_type, ^binary} = ClaimPredicateType.decode_xdr!(binary <> binary)
    end
  end
end
