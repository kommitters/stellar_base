defmodule Stellar.XDR.Operations.SetOptionsResultCode do
  @moduledoc """
  Representation of Stellar `SetOptionsResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # success
    SET_OPTIONS_SUCCESS: 0,
    # not enough funds to add a signer
    SET_OPTIONS_LOW_RESERVE: -1,
    # max number of signers already reached
    SET_OPTIONS_TOO_MANY_SIGNERS: -2,
    # invalid combination of clear/set flags
    SET_OPTIONS_BAD_FLAGS: -3,
    # inflation account does not exist
    SET_OPTIONS_INVALID_INFLATION: -4,
    # can no longer change this option
    SET_OPTIONS_CANT_CHANGE: -5,
    # can't set an unknown flag
    SET_OPTIONS_UNKNOWN_FLAG: -6,
    # bad value for weight/threshold
    SET_OPTIONS_THRESHOLD_OUT_OF_RANGE: -7,
    # signer cannot be masterkey
    SET_OPTIONS_BAD_SIGNER: -8,
    # malformed home domain
    SET_OPTIONS_INVALID_HOME_DOMAIN: -9,
    # auth revocable is required for clawback
    SET_OPTIONS_AUTH_REVOCABLE_REQUIRED: -10
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
