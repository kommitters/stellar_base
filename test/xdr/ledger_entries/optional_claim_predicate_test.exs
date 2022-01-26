defmodule StellarBase.XDR.OptionalClaimPredicateTest do
  use ExUnit.Case

  alias StellarBase.XDR.{ClaimPredicate, ClaimPredicateType, OptionalClaimPredicate, Void}

  describe "OptionalClaimPredicate" do
    setup do
      predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
      predicate = ClaimPredicate.new(Void.new(), predicate_type)

      %{
        optional_predicate: OptionalClaimPredicate.new(predicate),
        empty_predicate: OptionalClaimPredicate.new(nil),
        binary: <<0, 0, 0, 1, 0, 0, 0, 0>>
      }
    end

    test "new/1", %{optional_predicate: optional_predicate} do
      %OptionalClaimPredicate{predicate: ^optional_predicate} =
        OptionalClaimPredicate.new(optional_predicate)
    end

    test "new/1 no predicate opted" do
      %OptionalClaimPredicate{predicate: nil} = OptionalClaimPredicate.new(nil)
    end

    test "encode_xdr/1", %{optional_predicate: optional_predicate, binary: binary} do
      {:ok, ^binary} = OptionalClaimPredicate.encode_xdr(optional_predicate)
    end

    test "encode_xdr/1 no predicate opted", %{empty_predicate: empty_predicate} do
      {:ok, <<0, 0, 0, 0>>} = OptionalClaimPredicate.encode_xdr(empty_predicate)
    end

    test "encode_xdr!/1", %{optional_predicate: optional_predicate, binary: binary} do
      ^binary = OptionalClaimPredicate.encode_xdr!(optional_predicate)
    end

    test "decode_xdr/2", %{optional_predicate: optional_predicate, binary: binary} do
      {:ok, {^optional_predicate, ""}} = OptionalClaimPredicate.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = OptionalClaimPredicate.decode_xdr(1234)
    end

    test "decode_xdr/2 when predicate is not opted" do
      {:ok, {%OptionalClaimPredicate{predicate: nil}, ""}} =
        OptionalClaimPredicate.decode_xdr(<<0, 0, 0, 0>>)
    end

    test "decode_xdr!/2", %{optional_predicate: optional_predicate, binary: binary} do
      {^optional_predicate, ^binary} = OptionalClaimPredicate.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 when ClaimPredicate is not opted" do
      {%OptionalClaimPredicate{predicate: nil}, ""} =
        OptionalClaimPredicate.decode_xdr!(<<0, 0, 0, 0>>)
    end
  end
end
