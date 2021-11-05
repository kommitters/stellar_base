defmodule StellarBase.XDR.Operations.ChangeTrustResultCode do
  @moduledoc """
  Representation of Stellar `ChangeTrustResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # success
    CHANGE_TRUST_SUCCESS: 0,
    # bad input
    CHANGE_TRUST_MALFORMED: -1,
    # could not find issuer
    CHANGE_TRUST_NO_ISSUER: -2,
    # cannot drop limit below balance or cannot create with a limit of 0
    CHANGE_TRUST_INVALID_LIMIT: -3,
    # not enough funds to create a new trust line,
    CHANGE_TRUST_LOW_RESERVE: -4,
    # trusting self is not allowed
    CHANGE_TRUST_SELF_NOT_ALLOWED: -5,
    # Asset trustline is missing for pool
    CHANGE_TRUST_TRUST_LINE_MISSING: -6,
    # Asset trustline is still referenced in a pool
    CHANGE_TRUST_CANNOT_DELETE: -7,
    # Asset trustline is deauthorized
    CHANGE_TRUST_NOT_AUTH_MAINTAIN_LIABILITIES: -8
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(code :: atom()) :: t()
  def new(code), do: %__MODULE__{identifier: code}

  @impl true
  def encode_xdr(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: code}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(code), rest}
  end
end
