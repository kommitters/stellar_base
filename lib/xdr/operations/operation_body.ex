defmodule Stellar.XDR.OperationBody do
  @moduledoc """
  Representation of Stellar `OperationBody` type.
  """
  alias Stellar.XDR.{OperationType, Void}

  alias Stellar.XDR.Operations.{
    CreateAccount,
    ManageSellOffer,
    Payment,
    PathPaymentStrictReceive,
    PathPaymentStrictSend,
    ManageSellOffer,
    ManageBuyOffer,
    CreatePassiveSellOffer,
    SetOptions,
    ChangeTrust,
    AllowTrust,
    AccountMerge,
    ManageData,
    BumpSequence,
    ClaimClaimableBalance,
    BeginSponsoringFutureReserves,
    Clawback,
    ClawbackClaimableBalance,
    SetTrustLineFlags
  }

  @behaviour XDR.Declaration

  # XDR types for Operations will be implemented in #49.
  @arms [
    CREATE_ACCOUNT: CreateAccount,
    PAYMENT: Payment,
    PATH_PAYMENT_STRICT_RECEIVE: PathPaymentStrictReceive,
    MANAGE_SELL_OFFER: ManageSellOffer,
    CREATE_PASSIVE_SELL_OFFER: CreatePassiveSellOffer,
    SET_OPTIONS: SetOptions,
    CHANGE_TRUST: ChangeTrust,
    ALLOW_TRUST: AllowTrust,
    ACCOUNT_MERGE: AccountMerge,
    INFLATION: Void,
    MANAGE_DATA: ManageData,
    BUMP_SEQUENCE: BumpSequence,
    MANAGE_BUY_OFFER: ManageBuyOffer,
    PATH_PAYMENT_STRICT_SEND: PathPaymentStrictSend,
    # CREATE_CLAIMABLE_BALANCE: CreateClaimableBalance,
    CLAIM_CLAIMABLE_BALANCE: ClaimClaimableBalance,
    BEGIN_SPONSORING_FUTURE_RESERVES: BeginSponsoringFutureReserves,
    END_SPONSORING_FUTURE_RESERVES: Void,
    # REVOKE_SPONSORSHIP: RevokeSponsorship,
    CLAWBACK: Clawback,
    CLAWBACK_CLAIMABLE_BALANCE: ClawbackClaimableBalance,
    SET_TRUST_LINE_FLAGS: SetTrustLineFlags
    # LIQUIDITY_POOL_DEPOSIT: LiquidityPoolDeposit,
    # LIQUIDITY_POOL_WITHDRAW: LiquidityPoolWithdraw
  ]

  @type operation :: any()

  @type t :: %__MODULE__{operation: operation(), type: OperationType.t()}

  defstruct [:operation, :type]

  @spec new(operation :: operation(), type :: OperationType.t()) :: t()
  def new(operation, %OperationType{} = type),
    do: %__MODULE__{operation: operation, type: type}

  @impl true
  def encode_xdr(%__MODULE__{operation: operation, type: type}) do
    type
    |> XDR.Union.new(@arms, operation)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{operation: operation, type: type}) do
    type
    |> XDR.Union.new(@arms, operation)
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
    |> OperationType.new()
    |> XDR.Union.new(@arms)
  end
end
