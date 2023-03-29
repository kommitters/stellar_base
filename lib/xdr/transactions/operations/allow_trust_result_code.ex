defmodule StellarBase.XDR.Operations.AllowTrustResultCode do
  @moduledoc """
  Representation of Stellar `AllowTrustResultCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    # success
    ALLOW_TRUST_SUCCESS: 0,
    # asset is not ASSET_TYPE_ALPHANUM
    ALLOW_TRUST_MALFORMED: -1,
    # trustor does not have a trustline source
    ALLOW_TRUST_NO_TRUST_LINE: -2,
    # account does not require trust
    ALLOW_TRUST_TRUST_NOT_REQUIRED: -3,
    # source account can't revoke trust
    ALLOW_TRUST_CANT_REVOKE: -4,
    # trusting self is not allowed
    ALLOW_TRUST_SELF_NOT_ALLOWED: -5,
    # claimable balances can't be created on revoke due to low reserves
    ALLOW_TRUST_LOW_RESERVE: -6
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
