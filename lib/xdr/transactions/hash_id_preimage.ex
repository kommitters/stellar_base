defmodule StellarBase.XDR.HashIDPreimage do
  @moduledoc """
  Representation of Stellar `HashIDPreimage` type.
  """
  alias StellarBase.XDR.{EnvelopeType, OperationID, RevokeID}

  @behaviour XDR.Declaration

  @arms [
    ENVELOPE_TYPE_OP_ID: OperationID,
    ENVELOPE_TYPE_POOL_REVOKE_OP_ID: RevokeID
  ]

  @type hash_id :: OperationID.t() | RevokeID.t()

  @type t :: %__MODULE__{hash_id: hash_id(), type: EnvelopeType.t()}

  defstruct [:hash_id, :type]

  @spec new(hash_id :: hash_id(), type :: EnvelopeType.t()) :: t()
  def new(hash_id, %EnvelopeType{} = type),
    do: %__MODULE__{hash_id: hash_id, type: type}

  @impl true
  def encode_xdr(%__MODULE__{hash_id: hash_id, type: type}) do
    type
    |> XDR.Union.new(@arms, hash_id)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{hash_id: hash_id, type: type}) do
    type
    |> XDR.Union.new(@arms, hash_id)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, hash_id}, rest}} -> {:ok, {new(hash_id, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, hash_id}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(hash_id, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> EnvelopeType.new()
    |> XDR.Union.new(@arms)
  end
end
