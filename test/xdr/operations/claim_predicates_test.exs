defmodule Stellar.XDR.ClaimPredicatesTest do
  use ExUnit.Case

  alias Stellar.XDR.{ClaimPredicate, ClaimPredicateType, Int64, ClaimPredicates, Void}

  describe "ClaimPredicates" do
    setup do
      predicate_type1 = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
      predicate1 = Void.new()
      claim_predicate1 = ClaimPredicate.new(predicate1, predicate_type1)

      predicate_type2 = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
      predicate2 = Int64.new(1_000_000_000)
      claim_predicate2 = ClaimPredicate.new(predicate2, predicate_type2)

      claim_predicates = [claim_predicate1, claim_predicate2]

      %{
        claim_predicates_list: claim_predicates,
        claim_predicates: ClaimPredicates.new(claim_predicates),
        binary: <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{claim_predicates_list: claim_predicates_list} do
      %ClaimPredicates{predicates: ^claim_predicates_list} =
        ClaimPredicates.new(claim_predicates_list)
    end

    test "encode_xdr/1", %{claim_predicates: claim_predicates, binary: binary} do
      {:ok, ^binary} = ClaimPredicates.encode_xdr(claim_predicates)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> ClaimPredicates.new()
        |> ClaimPredicates.encode_xdr()
    end

    test "encode_xdr!/1", %{claim_predicates: claim_predicates, binary: binary} do
      ^binary = ClaimPredicates.encode_xdr!(claim_predicates)
    end

    test "decode_xdr/2", %{claim_predicates: claim_predicates, binary: binary} do
      {:ok, {^claim_predicates, ""}} = ClaimPredicates.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicates.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claim_predicates: claim_predicates, binary: binary} do
      {^claim_predicates, ^binary} = ClaimPredicates.decode_xdr!(binary <> binary)
    end
  end
end
