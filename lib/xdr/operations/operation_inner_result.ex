defmodule Stellar.XDR.OperationInnerResult do
  @moduledoc """
  Representation of Stellar `OperationInnerResult` type.
  """
  alias Stellar.XDR.OperationType

  alias Stellar.XDR.Operations.{
    AccountMergeResult,
    AllowTrustResult,
    BeginSponsoringFutureReservesResult,
    BumpSequenceResult,
    ChangeTrustResult,
    ClaimClaimableBalanceResult,
    ClawbackClaimableBalanceResult,
    ClawbackResult,
    CreateAccountResult,
    CreateClaimableBalanceResult,
    EndSponsoringFutureReservesResult,
    InflationResult,
    LiquidityPoolDepositResult,
    LiquidityPoolWithdrawResult,
    ManageDataResult,
    ManageSellOfferResult,
    ManageBuyOfferResult,
    PaymentResult,
    PathPaymentStrictReceiveResult,
    PathPaymentStrictSendResult,
    RevokeSponsorshipResult,
    SetOptionsResult,
    SetTrustLineFlagsResult
  }

  @behaviour XDR.Declaration

  @arms [
    CREATE_ACCOUNT: CreateAccountResult,
    PAYMENT: PaymentResult,
    PATH_PAYMENT_STRICT_RECEIVE: PathPaymentStrictReceiveResult,
    MANAGE_SELL_OFFER: ManageSellOfferResult,
    CREATE_PASSIVE_SELL_OFFER: ManageSellOfferResult,
    SET_OPTIONS: SetOptionsResult,
    CHANGE_TRUST: ChangeTrustResult,
    ALLOW_TRUST: AllowTrustResult,
    ACCOUNT_MERGE: AccountMergeResult,
    INFLATION: InflationResult,
    MANAGE_DATA: ManageDataResult,
    BUMP_SEQUENCE: BumpSequenceResult,
    MANAGE_BUY_OFFER: ManageBuyOfferResult,
    PATH_PAYMENT_STRICT_SEND: PathPaymentStrictSendResult,
    CREATE_CLAIMABLE_BALANCE: CreateClaimableBalanceResult,
    CLAIM_CLAIMABLE_BALANCE: ClaimClaimableBalanceResult,
    BEGIN_SPONSORING_FUTURE_RESERVES: BeginSponsoringFutureReservesResult,
    END_SPONSORING_FUTURE_RESERVES: EndSponsoringFutureReservesResult,
    REVOKE_SPONSORSHIP: RevokeSponsorshipResult,
    CLAWBACK: ClawbackResult,
    CLAWBACK_CLAIMABLE_BALANCE: ClawbackClaimableBalanceResult,
    SET_TRUST_LINE_FLAGS: SetTrustLineFlagsResult,
    LIQUIDITY_POOL_DEPOSIT: LiquidityPoolDepositResult,
    LIQUIDITY_POOL_WITHDRAW: LiquidityPoolWithdrawResult
  ]

  @type t :: %__MODULE__{result: any(), type: OperationType.t()}

  defstruct [:result, :type]

  @spec new(result :: any(), type :: OperationType.t()) :: t()
  def new(result, %OperationType{} = type),
    do: %__MODULE__{result: result, type: type}

  @impl true
  def encode_xdr(%__MODULE__{result: result, type: type}) do
    type
    |> XDR.Union.new(@arms, result)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{result: result, type: type}) do
    type
    |> XDR.Union.new(@arms, result)
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
