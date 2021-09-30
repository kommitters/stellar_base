defmodule Stellar.XDR.LedgerKey do
  @moduledoc """
  Representation of Stellar `LedgerEntry` type.
  """
  alias Stellar.XDR.LedgerEntryType

  alias Stellar.XDR.Ledger.{Account, TrustLine, Offer, Data, ClaimableBalance, LiquidityPool}

  @behaviour XDR.Declaration

  @arms [
    ACCOUNT: Account,
    TRUSTLINE: TrustLine,
    OFFER: Offer,
    DATA: Data,
    CLAIMABLE_BALANCE: ClaimableBalance,
    LIQUIDITY_POOL: LiquidityPool
  ]

  @type entry ::
          Account.t()
          | TrustLine.t()
          | Offer.t()
          | Data.t()
          | ClaimableBalance.t()
          | LiquidityPool.t()

  @type t :: %__MODULE__{entry: entry(), type: LedgerEntryType.t()}

  defstruct [:entry, :type]

  @spec new(entry :: entry(), type :: LedgerEntryType.t()) :: t()
  def new(entry, %LedgerEntryType{} = type),
    do: %__MODULE__{entry: entry, type: type}

  @impl true
  def encode_xdr(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, key}, rest}} -> {:ok, {new(key, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, key}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(key, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> LedgerEntryType.new()
    |> XDR.Union.new(@arms)
  end
end
