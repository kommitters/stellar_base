defmodule StellarBase.XDR.EnvelopeType do
  @moduledoc """
  Representation of Stellar `EnvelopeType` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    ENVELOPE_TYPE_TX_V0: 0,
    ENVELOPE_TYPE_SCP: 1,
    ENVELOPE_TYPE_TX: 2,
    ENVELOPE_TYPE_AUTH: 3,
    ENVELOPE_TYPE_SCPVALUE: 4,
    ENVELOPE_TYPE_TX_FEE_BUMP: 5,
    ENVELOPE_TYPE_OP_ID: 6,
    ENVELOPE_TYPE_POOL_REVOKE_OP_ID: 7
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :ENVELOPE_TYPE_TX_V0), do: %__MODULE__{identifier: type}

  @impl true
  def encode_xdr(%__MODULE__{identifier: type}) do
    @declarations
    |> XDR.Enum.new(type)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: type}) do
    @declarations
    |> XDR.Enum.new(type)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: type}, rest}} -> {:ok, {new(type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: type}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(type), rest}
  end
end
