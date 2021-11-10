defmodule StellarBase.XDR.Operations.CreateClaimableBalanceTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    AccountID,
    AlphaNum4,
    Asset,
    AssetCode4,
    AssetType,
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

  alias StellarBase.XDR.Operations.CreateClaimableBalance

  describe "CreateClaimableBalance Operation" do
    setup do
      pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

      issuer =
        "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
        |> StrKey.decode!(:ed25519_public_key)
        |> UInt256.new()
        |> PublicKey.new(pk_type)
        |> AccountID.new()

      asset =
        "BTCN"
        |> AssetCode4.new()
        |> AlphaNum4.new(issuer)
        |> Asset.new(AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4))

      amount = Int64.new(100_000_000)

      claimant1 =
        create_claimant(
          "GBZQJBUQ7EEKVVFZH22J4JIHJHGUWHAUDFZFXZH4MJ6ZYMILOXC33GB5",
          :CLAIM_PREDICATE_UNCONDITIONAL
        )

      claimant2 =
        create_claimant(
          "GDP7PRVNX72M2G4J6CLZZXSYVEIRMFPB7SWPOY4CG22O5AFCOC2YEHGQ",
          :CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME
        )

      claimants = Claimants.new([claimant1, claimant2])

      %{
        asset: asset,
        amount: amount,
        claimants: claimants,
        claimable_balance: CreateClaimableBalance.new(asset, amount, claimants),
        binary:
          <<0, 0, 0, 1, 66, 84, 67, 78, 0, 0, 0, 0, 114, 213, 178, 144, 98, 27, 186, 154, 137, 68,
            149, 154, 124, 205, 198, 221, 187, 173, 152, 33, 210, 37, 10, 76, 25, 212, 179, 73,
            138, 2, 227, 119, 0, 0, 0, 0, 5, 245, 225, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 115,
            4, 134, 144, 249, 8, 170, 212, 185, 62, 180, 158, 37, 7, 73, 205, 75, 28, 20, 25, 114,
            91, 228, 252, 98, 125, 156, 49, 11, 117, 197, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            223, 247, 198, 173, 191, 244, 205, 27, 137, 240, 151, 156, 222, 88, 169, 17, 22, 21,
            225, 252, 172, 247, 99, 130, 54, 180, 238, 128, 162, 112, 181, 130, 0, 0, 0, 4, 0, 0,
            0, 0, 59, 154, 202, 0>>
      }
    end

    test "new/1", %{asset: asset, amount: amount, claimants: claimants} do
      %CreateClaimableBalance{asset: ^asset, amount: ^amount, claimants: ^claimants} =
        CreateClaimableBalance.new(asset, amount, claimants)
    end

    test "encode_xdr/1", %{claimable_balance: claimable_balance, binary: binary} do
      {:ok, ^binary} = CreateClaimableBalance.encode_xdr(claimable_balance)
    end

    test "encode_xdr!/1", %{claimable_balance: claimable_balance, binary: binary} do
      ^binary = CreateClaimableBalance.encode_xdr!(claimable_balance)
    end

    test "decode_xdr/2", %{claimable_balance: claimable_balance, binary: binary} do
      {:ok, {^claimable_balance, ""}} = CreateClaimableBalance.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = CreateClaimableBalance.decode_xdr(123)
    end

    test "decode_xdr!/2", %{claimable_balance: claimable_balance, binary: binary} do
      {^claimable_balance, ^binary} = CreateClaimableBalance.decode_xdr!(binary <> binary)
    end
  end

  @spec create_claimant(public_key :: binary(), claim_predicate_type :: atom()) :: Claimant.t()
  defp create_claimant(public_key, claim_predicate_type) do
    pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)
    claimant_type = ClaimantType.new(:CLAIMANT_TYPE_V0)
    predicate = create_claim_predicate(claim_predicate_type)

    public_key
    |> StrKey.decode!(:ed25519_public_key)
    |> UInt256.new()
    |> PublicKey.new(pk_type)
    |> AccountID.new()
    |> ClaimantV0.new(predicate)
    |> Claimant.new(claimant_type)
  end

  @spec create_claim_predicate(type :: atom()) :: ClaimPredicate.t()
  defp create_claim_predicate(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME) do
    predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME)
    ClaimPredicate.new(Int64.new(1_000_000_000), predicate_type)
  end

  defp create_claim_predicate(_type) do
    predicate_type = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
    ClaimPredicate.new(Void.new(), predicate_type)
  end
end
