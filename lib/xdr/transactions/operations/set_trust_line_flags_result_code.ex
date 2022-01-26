defmodule StellarBase.XDR.Operations.SetTrustLineFlagsResultCode do
  @moduledoc """
  Representation of Stellar `SetTrustLineFlagsResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # success
    SET_TRUST_LINE_FLAGS_SUCCESS: 0,
    # failure
    SET_TRUST_LINE_FLAGS_MALFORMED: -1,
    SET_TRUST_LINE_FLAGS_NO_TRUST_LINE: -2,
    SET_TRUST_LINE_FLAGS_CANT_REVOKE: -3,
    SET_TRUST_LINE_FLAGS_INVALID_STATE: -4,
    # claimable balances can't be created on revoke due to low reserves
    SET_TRUST_LINE_FLAGS_LOW_RESERVE: -5
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
