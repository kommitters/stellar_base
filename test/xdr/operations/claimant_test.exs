defmodule StellarBase.XDR.ClaimantTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    Claimant,
    ClaimantType,
    ClaimantV0,
    ClaimPredicateType,
    ClaimPredicate,
    PublicKey,
    PublicKeyType,
    UInt256,
    Void
  }

  describe "Claimant" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
      claim_predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
      claim_predicate = ClaimPredicate.new(Void.new(), claim_predicate_type)

      claimant_type = ClaimantType.new(:CLAIMANT_TYPE_V0)

      claimant_v0 =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StellarBase.Ed25519.PublicKey.decode!()
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()
        |> ClaimantV0.new(claim_predicate)

      %{
        claimant_v0: claimant_v0,
        claimant_type: claimant_type,
        claimant: Claimant.new(claimant_v0, claimant_type),
        binary:
          <<0, 0, 0, 0, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124,
            205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119,
            0, 0, 0, 0>>
      }
    end

    test "new/1", %{claimant_v0: claimant_v0, claimant_type: claimant_type} do
      %Claimant{claimant: ^claimant_v0, type: ^claimant_type} =
        Claimant.new(claimant_v0, claimant_type)
    end

    test "encode_xdr/1", %{claimant: claimant, binary: binary} do
      {:ok, ^binary} = Claimant.encode_xdr(claimant)
    end

    test "encode_xdr!/1", %{claimant: claimant, binary: binary} do
      ^binary = Claimant.encode_xdr!(claimant)
    end

    test "decode_xdr/2", %{claimant: claimant, binary: binary} do
      {:ok, {^claimant, ""}} = Claimant.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Claimant.decode_xdr(1234)
    end

    test "decode_xdr!/2", %{claimant: claimant, binary: binary} do
      {^claimant, ^binary} = Claimant.decode_xdr!(binary <> binary)
    end
  end
end
