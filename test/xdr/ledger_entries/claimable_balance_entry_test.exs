defmodule StellarBase.XDR.ClaimableBalanceEntryTest do
  use ExUnit.Case

  # alias StellarBase.XDR.{
  #   ClaimableBalanceEntry,
  #   ClaimableBalanceID,
  #   Hash,
  #   ClaimableBalanceIDType,
  #   Uint256,
  #   PublicKey,
  #   AccountID,
  #   ClaimantV0,
  #   Claimant,
  #   Asset,
  #   Void,
  #   AssetType,
  #   ClaimableBalanceEntryExtV1,
  #   Ext,
  #   Uint32,
  #   PublicKeyType,
  #   ClaimPredicateType,
  #   ClaimPredicate,
  #   ClaimantType,
  #   Int64,
  #   ClaimableBalanceEntryExt
  # }

  # alias StellarBase.StrKey

  # @arms [
  #   %{type: 0, value: Void.new()},
  #   %{type: 1, value: ClaimableBalanceEntryExtV1.new(Ext.new(), Uint32.new(1))}
  # ]

  # describe "ClaimableBalanceEntry" do
  #   setup do
  #     claimable_balance_id =
  #       "GCIZ3GSM5XL7OUS4UP64THMDZ7CZ3ZWN"
  #       |> Hash.new()
  #       |> ClaimableBalanceID.new(ClaimableBalanceIDType.new(:CLAIMABLE_BALANCE_ID_TYPE_V0))

  #     pk_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

  #     claim_predicate_type1 = ClaimPredicateType.new(:CLAIM_PREDICATE_UNCONDITIONAL)
  #     claim_predicate1 = ClaimPredicate.new(Void.new(), claim_predicate_type1)

  #     claimant_type = ClaimantType.new(:CLAIMANT_TYPE_V0)

  #     claimant =
  #       "GBZNLMUQMIN3VGUJISKZU7GNY3O3XLMYEHJCKCSMDHKLGSMKALRXOEZD"
  #       |> StrKey.decode!(:ed25519_public_key)
  #       |> Uint256.new()
  #       |> PublicKey.new(pk_type)
  #       |> AccountID.new()
  #       |> ClaimantV0.new(claim_predicate1)
  #       |> Claimant.new(claimant_type)

  #     asset = Asset.new(Void.new(), AssetType.new(:ASSET_TYPE_NATIVE))

  #     amount = Int64.new(1)

  #     claimable_balance_entry_ext_list =
  #       @arms
  #       |> Enum.map(fn %{type: type, value: value} ->
  #         ClaimableBalanceEntryExt.new(value, type)
  #       end)

  #     %{
  #       claimable_balance_id: claimable_balance_id,
  #       claimant: claimant,
  #       asset: asset,
  #       amount: amount,
  #       claimable_balance_entry_ext_list: claimable_balance_entry_ext_list,
  #       claimable_balance_entry_list:
  #         claimable_balance_entry_ext_list
  #         |> Enum.map(fn claimable_balance_entry_ext ->
  #           ClaimableBalanceEntry.new(
  #             claimable_balance_id,
  #             claimant,
  #             asset,
  #             amount,
  #             claimable_balance_entry_ext
  #           )
  #         end),
  #       binaries: [
  #         <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
  #           54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 0, 0, 0, 0, 114,
  #           213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152,
  #           33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  #           0, 0, 0, 0, 0, 1, 0, 0, 0, 0>>,
  #         <<0, 0, 0, 0, 71, 67, 73, 90, 51, 71, 83, 77, 53, 88, 76, 55, 79, 85, 83, 52, 85, 80,
  #           54, 52, 84, 72, 77, 68, 90, 55, 67, 90, 51, 90, 87, 78, 0, 0, 0, 0, 0, 0, 0, 0, 114,
  #           213, 178, 144, 98, 27, 186, 154, 137, 68, 149, 154, 124, 205, 198, 221, 187, 173, 152,
  #           33, 210, 37, 10, 76, 25, 212, 179, 73, 138, 2, 227, 119, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  #           0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1>>
  #       ]
  #     }
  #   end

  #   test "new/1", %{
  #     claimable_balance_id: claimable_balance_id,
  #     claimant: claimant,
  #     asset: asset,
  #     amount: amount,
  #     claimable_balance_entry_ext_list: claimable_balance_entry_ext_list
  #   } do
  #     for claimable_balance_entry_ext <- claimable_balance_entry_ext_list,
  #         do:
  #           %ClaimableBalanceEntry{
  #             claimable_balance_id: ^claimable_balance_id,
  #             claimant: ^claimant,
  #             asset: ^asset,
  #             amount: ^amount,
  #             claimable_balance_entry_ext: ^claimable_balance_entry_ext
  #           } =
  #             ClaimableBalanceEntry.new(
  #               claimable_balance_id,
  #               claimant,
  #               asset,
  #               amount,
  #               claimable_balance_entry_ext
  #             )
  #   end

  #   test "encode_xdr/1", %{
  #     claimable_balance_entry_list: claimable_balance_entry_list,
  #     binaries: binaries
  #   } do
  #     for {value, binary} <- Enum.zip(claimable_balance_entry_list, binaries),
  #         do: {:ok, ^binary} = ClaimableBalanceEntry.encode_xdr(value)
  #   end

  #   test "encode_xdr!/1", %{
  #     claimable_balance_entry_list: claimable_balance_entry_list,
  #     binaries: binaries
  #   } do
  #     for {value, binary} <- Enum.zip(claimable_balance_entry_list, binaries),
  #         do: ^binary = ClaimableBalanceEntry.encode_xdr!(value)
  #   end

  #   test "decode_xdr/2", %{
  #     claimable_balance_entry_list: claimable_balance_entry_list,
  #     binaries: binaries
  #   } do
  #     for {value, binary} <- Enum.zip(claimable_balance_entry_list, binaries),
  #         do: {:ok, {^value, ""}} = ClaimableBalanceEntry.decode_xdr(binary)
  #   end

  #   test "decode_xdr/2 with an invalid binary" do
  #     {:error, :not_binary} = ClaimableBalanceEntry.decode_xdr(123)
  #   end

  #   test "decode_xdr!/2", %{
  #     claimable_balance_entry_list: claimable_balance_entry_list,
  #     binaries: binaries
  #   } do
  #     for {value, binary} <- Enum.zip(claimable_balance_entry_list, binaries),
  #         do: {^value, ^binary} = ClaimableBalanceEntry.decode_xdr!(binary <> binary)
  #   end
  # end
end
