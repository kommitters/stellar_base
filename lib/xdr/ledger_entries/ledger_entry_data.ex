defmodule StellarBase.XDR.LedgerEntryData do
  @moduledoc """
  Representation of Stellar `LedgerEntryData` type.
  """

  alias StellarBase.XDR.{
    AccountEntry,
    TrustLineEntry,
    OfferEntry,
    DataEntry,
    ClaimableBalance,
    LiquidityPool,
    ContractDataEntry,
    ContractCodeEntry,
    ConfigSettingEntry,
    ClaimableBalanceEntry,
    LiquidityPoolEntry,
    LedgerEntryType,
    ExpirationEntry
  }

  @behaviour XDR.Declaration

  @arms [
    ACCOUNT: AccountEntry,
    TRUSTLINE: TrustLineEntry,
    OFFER: OfferEntry,
    DATA: DataEntry,
    CLAIMABLE_BALANCE: ClaimableBalance,
    LIQUIDITY_POOL: LiquidityPool,
    CONTRACT_DATA: ContractDataEntry,
    CONTRACT_CODE: ContractCodeEntry,
    CONFIG_SETTING: ConfigSettingEntry,
    EXPIRATION: ExpirationEntry
  ]

  @type entry ::
          AccountEntry.t()
          | TrustLineEntry.t()
          | OfferEntry.t()
          | DataEntry.t()
          | ClaimableBalanceEntry.t()
          | LiquidityPoolEntry.t()
          | ContractDataEntry.t()
          | ContractCodeEntry.t()
          | ConfigSettingEntry.t()
          | ExpirationEntry.t()

  @type t :: %__MODULE__{entry: entry(), type: LedgerEntryType.t()}

  defstruct [:entry, :type]

  @spec new(entry :: entry(), type :: LedgerEntryType.t()) :: t()
  def new(entry, %LedgerEntryType{} = type), do: %__MODULE__{entry: entry, type: type}

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
