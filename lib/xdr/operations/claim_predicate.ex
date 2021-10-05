defmodule Stellar.XDR.ClaimPredicate do
  @moduledoc """
  Representation of Stellar `ClaimPredicate` type.
  """
  alias Stellar.XDR.{ClaimPredicateType, Int64, OptionalClaimPredicate, ClaimPredicates, Void}

  @behaviour XDR.Declaration

  @arms [
    CLAIM_PREDICATE_UNCONDITIONAL: Void,
    CLAIM_PREDICATE_AND: ClaimPredicates,
    CLAIM_PREDICATE_OR: ClaimPredicates,
    CLAIM_PREDICATE_NOT: OptionalClaimPredicate,
    CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME: Int64,
    CLAIM_PREDICATE_BEFORE_RELATIVE_TIME: Int64
  ]

  @type predicate :: Void.t() | ClaimPredicates.t() | OptionalClaimPredicate.t() | Int64.t()

  @type t :: %__MODULE__{predicate: predicate(), type: ClaimPredicateType.t()}

  defstruct [:predicate, :type]

  @spec new(predicate :: predicate(), type :: ClaimPredicateType.t()) :: t()
  def new(predicate, %ClaimPredicateType{} = type),
    do: %__MODULE__{predicate: predicate, type: type}

  @impl true
  def encode_xdr(%__MODULE__{predicate: predicate, type: type}) do
    type
    |> XDR.Union.new(@arms, predicate)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{predicate: predicate, type: type}) do
    type
    |> XDR.Union.new(@arms, predicate)
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
    |> ClaimPredicateType.new()
    |> XDR.Union.new(@arms)
  end
end
