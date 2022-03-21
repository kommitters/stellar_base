defmodule StellarBase.XDR.ClaimableBalanceEntry do
  @moduledoc """
  Representation of Stellar `ClaimableBalanceEntry` type.
  """
  alias StellarBase.XDR.{ClaimableBalanceID, Claimant, Asset, Int64, ClaimableBalanceEntryExt}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 claimable_balance_id: ClaimableBalanceID,
                 claimant: Claimant,
                 asset: Asset,
                 amount: Int64,
                 claimable_balance_entry_ext: ClaimableBalanceEntryExt
               )

  @type t :: %__MODULE__{
          claimable_balance_id: ClaimableBalanceID.t(),
          claimant: Claimant.t(),
          asset: Asset.t(),
          amount: Int64.t(),
          claimable_balance_entry_ext: ClaimableBalanceEntryExt.t()
        }

  defstruct [:claimable_balance_id, :claimant, :asset, :amount, :claimable_balance_entry_ext]

  @spec new(
          claimable_balance_id :: ClaimableBalanceID.t(),
          claimant :: Claimant.t(),
          asset :: Asset.t(),
          amount :: Int64.t(),
          claimable_balance_entry_ext :: ClaimableBalanceEntryExt.t()
        ) :: t()
  def new(
        %ClaimableBalanceID{} = claimable_balance_id,
        %Claimant{} = claimant,
        %Asset{} = asset,
        %Int64{} = amount,
        %ClaimableBalanceEntryExt{} = claimable_balance_entry_ext
      ),
      do: %__MODULE__{
        claimable_balance_id: claimable_balance_id,
        claimant: claimant,
        asset: asset,
        amount: amount,
        claimable_balance_entry_ext: claimable_balance_entry_ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        claimable_balance_id: claimable_balance_id,
        claimant: claimant,
        asset: asset,
        amount: amount,
        claimable_balance_entry_ext: claimable_balance_entry_ext
      }) do
    [
      claimable_balance_id: claimable_balance_id,
      claimant: claimant,
      asset: asset,
      amount: amount,
      claimable_balance_entry_ext: claimable_balance_entry_ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        claimable_balance_id: claimable_balance_id,
        claimant: claimant,
        asset: asset,
        amount: amount,
        claimable_balance_entry_ext: claimable_balance_entry_ext
      }) do
    [
      claimable_balance_id: claimable_balance_id,
      claimant: claimant,
      asset: asset,
      amount: amount,
      claimable_balance_entry_ext: claimable_balance_entry_ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            claimable_balance_id: claimable_balance_id,
            claimant: claimant,
            asset: asset,
            amount: amount,
            claimable_balance_entry_ext: claimable_balance_entry_ext
          ]
        }, rest}} ->
        {:ok,
         {new(
            claimable_balance_id,
            claimant,
            asset,
            amount,
            claimable_balance_entry_ext
          ), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         claimable_balance_id: claimable_balance_id,
         claimant: claimant,
         asset: asset,
         amount: amount,
         claimable_balance_entry_ext: claimable_balance_entry_ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       claimable_balance_id,
       claimant,
       asset,
       amount,
       claimable_balance_entry_ext
     ), rest}
  end
end
