defmodule StellarBase.XDR.Operations.ClaimantV0Test do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    ClaimantV0,
    ClaimPredicateType,
    ClaimPredicate,
    Int64,
    PublicKey,
    PublicKeyType,
    UInt256
  }

  describe "ClaimantV0" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      destination =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StellarBase.Ed25519.PublicKey.decode!()
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
      predicate = Int64.new(1_000_000_000)
      claim_predicate = ClaimPredicate.new(predicate, predicate_type)

      %{
        destination: destination,
        claim_predicate: claim_predicate,
        claimant_v0: ClaimantV0.new(destination, claim_predicate),
        binary:
          <<0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198,
            221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0,
            4, 0, 0, 0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{destination: destination, claim_predicate: claim_predicate} do
      %ClaimantV0{destination: ^destination, predicate: ^claim_predicate} =
        ClaimantV0.new(destination, claim_predicate)
    end

    test "encode_xdr/1", %{claimant_v0: claimant_v0, binary: binary} do
      {:ok, ^binary} = ClaimantV0.encode_xdr(claimant_v0)
    end

    test "encode_xdr!/1", %{claimant_v0: claimant_v0, binary: binary} do
      ^binary = ClaimantV0.encode_xdr!(claimant_v0)
    end

    test "decode_xdr/2", %{claimant_v0: claimant_v0, binary: binary} do
      {:ok, {^claimant_v0, ""}} = ClaimantV0.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = ClaimantV0.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claimant_v0: claimant_v0, binary: binary} do
      {^claimant_v0, ^binary} = ClaimantV0.decode_xdr!(binary <> binary)
    end
  end
end
