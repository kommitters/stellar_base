defmodule StellarBase.XDR.TransactionSignaturePayloadTaggedTransaction do
  @moduledoc """
  Representation of Stellar `TransactionSignaturePayloadTaggedTransaction` type.
  """
  alias StellarBase.XDR.{EnvelopeType, Transaction, FeeBumpTransaction}

  @behaviour XDR.Declaration

  @arms [
    ENVELOPE_TYPE_TX: Transaction,
    ENVELOPE_TYPE_TX_FEE_BUMP: FeeBumpTransaction
  ]

  @type transaction :: Transaction.t() | FeeBumpTransaction.t()

  @type t :: %__MODULE__{transaction: transaction(), type: EnvelopeType.t()}

  defstruct [:transaction, :type]

  @spec new(transaction :: transaction(), type :: EnvelopeType.t()) :: t()
  def new(transaction, %EnvelopeType{} = type),
    do: %__MODULE__{transaction: transaction, type: type}

  @impl true
  def encode_xdr(%__MODULE__{transaction: transaction, type: type}) do
    type
    |> XDR.Union.new(@arms, transaction)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{transaction: transaction, type: type}) do
    type
    |> XDR.Union.new(@arms, transaction)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, transaction}, rest}} -> {:ok, {new(transaction, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, transaction}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(transaction, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> EnvelopeType.new()
    |> XDR.Union.new(@arms)
  end
end
