defmodule StellarBase.XDR.ClaimantsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    Claimant,
    Claimants,
    ClaimantType,
    ClaimantV0,
    ClaimPredicateType,
    ClaimPredicate,
    Int64,
    PublicKey,
    PublicKeyType,
    UInt256,
    Void
  }

  alias StellarBase.StrKey

  describe "Claimants" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      claim_predicate_type1 = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
      claim_predicate1 = ClaimPredicate.new(Void.new(), claim_predicate_type1)

      claim_predicate_type2 = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
      claim_predicate2 = ClaimPredicate.new(Int64.new(1_000_000_000), claim_predicate_type2)

      claimant_type = ClaimantType.new(:CLAIMANT_TYPE_V0)

      claimant1 =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()
        |> ClaimantV0.new(claim_predicate1)
        |> Claimant.new(claimant_type)

      claimant2 =
        "GDP7PRVNX72M2G4J6CLZZXSYVEIRMFPB7SWPOY4CG22O5AFCOC2YEHGQ"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()
        |> ClaimantV0.new(claim_predicate2)
        |> Claimant.new(claimant_type)

      claimants_list = [claimant1, claimant2]

      %{
        claimants_list: claimants_list,
        claimants: Claimants.new(claimants_list),
        binary:
          <<0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 223, 247, 198, 173, 191, 244,
            205, 27, 137, 240, 151, 156, 222, 88, 169, 17, 22, 21, 225, 252, 172, 247, 99, 130,
            54, 180, 238, 128, 162, 112, 181, 130, 0, 0, 0, 4, 0, 0, 0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{claimants_list: claimants_list} do
      %Claimants{claimants: ^claimants_list} = Claimants.new(claimants_list)
    end

    test "encode_xdr/1", %{claimants: claimants, binary: binary} do
      {:ok, ^binary} = Claimants.encode_xdr(claimants)
    end

    test "encode_xdr/1 with invalid elements" do
      {:error, :not_list} =
        %{elements: nil}
        |> Claimants.new()
        |> Claimants.encode_xdr()
    end

    test "encode_xdr!/1", %{claimants: claimants, binary: binary} do
      ^binary = Claimants.encode_xdr!(claimants)
    end

    test "decode_xdr/2", %{claimants: claimants, binary: binary} do
      {:ok, {^claimants, ""}} = Claimants.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Claimants.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claimants: claimants, binary: binary} do
      {^claimants, ^binary} = Claimants.decode_xdr!(binary <> binary)
    end
  end
end
