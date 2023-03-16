defmodule StellarBase.XDR.FeeBumpInnerTx do
  @moduledoc """
  Representation of Stellar `FeeBumpInnerTx` type.
  """
  alias StellarBase.XDR.{EnvelopeType, TransactionV1Envelope}

  @behaviour XDR.Declaration

  @arms [ENVELOPE_TYPE_TX: TransactionV1Envelope]

  @type envelope :: TransactionV1Envelope.t()

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
