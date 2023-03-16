defmodule StellarBase.XDR.TransactionEnvelope do
  @moduledoc """
  Representation of Stellar `TransactionEnvelope` type.
  """
  alias StellarBase.XDR.{
    EnvelopeType,
    TransactionV0Envelope,
    TransactionV1Envelope,
    FeeBumpTransactionEnvelope
  }

  @behaviour XDR.Declaration

  @arms [
    ENVELOPE_TYPE_TX_V0: TransactionV0Envelope,
    ENVELOPE_TYPE_TX: TransactionV1Envelope,
    ENVELOPE_TYPE_TX_FEE_BUMP: FeeBumpTransactionEnvelope
  ]

  @type envelope ::
          TransactionV0Envelope.t() | TransactionV1Envelope.t() | FeeBumpTransactionEnvelope.t()

  @type t :: %__MODULE__{envelope: envelope(), type: EnvelopeType.t()}

  defstruct [:envelope, :type]

  @spec new(envelope :: envelope(), type :: EnvelopeType.t()) :: t()
  def new(envelope, %EnvelopeType{} = type), do: %__MODULE__{envelope: envelope, type: type}

  @impl true
  def encode_xdr(%__MODULE__{envelope: envelope, type: type}) do
    type
    |> XDR.Union.new(@arms, envelope)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{envelope: envelope, type: type}) do
    type
    |> XDR.Union.new(@arms, envelope)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, envelope}, rest}} -> {:ok, {new(envelope, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, envelope}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(envelope, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> EnvelopeType.new()
    |> XDR.Union.new(@arms)
  end
end
