defmodule StellarBase.XDR.ClaimPredicateTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    ClaimPredicate,
    ClaimPredicateType,
    Int64,
    OptionalClaimPredicate,
    ClaimPredicates,
    Void
  }

  describe "Unconditional ClaimPredicate" do
    setup do
      predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
      predicate = Void.new()

      %{
        predicate: predicate,
        predicate_type: predicate_type,
        claim_predicate: ClaimPredicate.new(predicate, predicate_type),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{predicate: predicate, predicate_type: predicate_type} do
      %ClaimPredicate{value: ^predicate, type: ^predicate_type} =
        ClaimPredicate.new(predicate, predicate_type)
    end

    test "encode_xdr/1", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, ^binary} = ClaimPredicate.encode_xdr(claim_predicate)
    end

    test "encode_xdr!/1", %{claim_predicate: claim_predicate, binary: binary} do
      ^binary = ClaimPredicate.encode_xdr!(claim_predicate)
    end

    test "decode_xdr/2", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, {^claim_predicate, ""}} = ClaimPredicate.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicate.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{claim_predicate: claim_predicate, binary: binary} do
      {^claim_predicate, ^binary} = ClaimPredicate.decode_xdr!(binary <> binary)
    end
  end

  describe "PredicateAnd ClaimPredicate" do
    setup do
      predicate_type1 = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
      predicate1 = Void.new()
      claim_predicate1 = ClaimPredicate.new(predicate1, predicate_type1)

      predicate_type2 = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
      predicate2 = Int64.new(1_000_000_000)
      claim_predicate2 = ClaimPredicate.new(predicate2, predicate_type2)

      predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_AND)
      predicate = ClaimPredicates.new([claim_predicate1, claim_predicate2])

      %{
        predicate: predicate,
        predicate_type: predicate_type,
        claim_predicate: ClaimPredicate.new(predicate, predicate_type),
        binary: <<0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{predicate: predicate, predicate_type: predicate_type} do
      %ClaimPredicate{value: ^predicate, type: ^predicate_type} =
        ClaimPredicate.new(predicate, predicate_type)
    end

    test "encode_xdr/1", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, ^binary} = ClaimPredicate.encode_xdr(claim_predicate)
    end

    test "encode_xdr!/1", %{claim_predicate: claim_predicate, binary: binary} do
      ^binary = ClaimPredicate.encode_xdr!(claim_predicate)
    end

    test "decode_xdr/2", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, {^claim_predicate, ""}} = ClaimPredicate.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicate.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{claim_predicate: claim_predicate, binary: binary} do
      {^claim_predicate, ^binary} = ClaimPredicate.decode_xdr!(binary <> binary)
    end
  end

  describe "PredicateOr ClaimPredicate" do
    setup do
      predicate_type1 = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
      predicate1 = Void.new()
      claim_predicate1 = ClaimPredicate.new(predicate1, predicate_type1)

      predicate_type2 = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
      predicate2 = Int64.new(1_000_000_000)
      claim_predicate2 = ClaimPredicate.new(predicate2, predicate_type2)

      predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_OR)
      predicate = ClaimPredicates.new([claim_predicate1, claim_predicate2])

      %{
        predicate: predicate,
        predicate_type: predicate_type,
        claim_predicate: ClaimPredicate.new(predicate, predicate_type),
        binary: <<0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{predicate: predicate, predicate_type: predicate_type} do
      %ClaimPredicate{value: ^predicate, type: ^predicate_type} =
        ClaimPredicate.new(predicate, predicate_type)
    end

    test "encode_xdr/1", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, ^binary} = ClaimPredicate.encode_xdr(claim_predicate)
    end

    test "encode_xdr!/1", %{claim_predicate: claim_predicate, binary: binary} do
      ^binary = ClaimPredicate.encode_xdr!(claim_predicate)
    end

    test "decode_xdr/2", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, {^claim_predicate, ""}} = ClaimPredicate.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicate.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{claim_predicate: claim_predicate, binary: binary} do
      {^claim_predicate, ^binary} = ClaimPredicate.decode_xdr!(binary <> binary)
    end
  end

  describe "Optional ClaimPredicate" do
    setup do
      predicate_type1 = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
      predicate1 = Int64.new(1_000_000_000)
      claim_predicate1 = ClaimPredicate.new(predicate1, predicate_type1)

      predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_NOT)
      predicate = OptionalClaimPredicate.new(claim_predicate1)

      %{
        predicate: predicate,
        predicate_type: predicate_type,
        claim_predicate: ClaimPredicate.new(predicate, predicate_type),
        binary: <<0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 4, 0, 0, 0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{predicate: predicate, predicate_type: predicate_type} do
      %ClaimPredicate{value: ^predicate, type: ^predicate_type} =
        ClaimPredicate.new(predicate, predicate_type)
    end

    test "encode_xdr/1", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, ^binary} = ClaimPredicate.encode_xdr(claim_predicate)
    end

    test "encode_xdr!/1", %{claim_predicate: claim_predicate, binary: binary} do
      ^binary = ClaimPredicate.encode_xdr!(claim_predicate)
    end

    test "decode_xdr/2", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, {^claim_predicate, ""}} = ClaimPredicate.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicate.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{claim_predicate: claim_predicate, binary: binary} do
      {^claim_predicate, ^binary} = ClaimPredicate.decode_xdr!(binary <> binary)
    end
  end

  describe "Time ClaimPredicate" do
    setup do
      predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
      predicate = Int64.new(1_000_000_000)

      %{
        predicate: predicate,
        predicate_type: predicate_type,
        claim_predicate: ClaimPredicate.new(predicate, predicate_type),
        binary: <<0, 0, 0, 4, 0, 0, 0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{predicate: predicate, predicate_type: predicate_type} do
      %ClaimPredicate{value: ^predicate, type: ^predicate_type} =
        ClaimPredicate.new(predicate, predicate_type)
    end

    test "encode_xdr/1", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, ^binary} = ClaimPredicate.encode_xdr(claim_predicate)
    end

    test "encode_xdr!/1", %{claim_predicate: claim_predicate, binary: binary} do
      ^binary = ClaimPredicate.encode_xdr!(claim_predicate)
    end

    test "decode_xdr/2", %{claim_predicate: claim_predicate, binary: binary} do
      {:ok, {^claim_predicate, ""}} = ClaimPredicate.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimPredicate.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{claim_predicate: claim_predicate, binary: binary} do
      {^claim_predicate, ^binary} = ClaimPredicate.decode_xdr!(binary <> binary)
    end
  end
end
