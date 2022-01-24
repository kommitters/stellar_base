defmodule StellarBase.XDR.Operations.PaymentResultCode do
  @moduledoc """
  Representation of Stellar `PaymentResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # payment successfully completed
    PAYMENT_SUCCESS: 0,
    # bad input
    PAYMENT_MALFORMED: -1,
    # not enough funds in source account
    PAYMENT_UNDERFUNDED: -2,
    # no trust line on source account
    PAYMENT_SRC_NO_TRUST: -3,
    # source not authorized to transfer
    PAYMENT_SRC_NOT_AUTHORIZED: -4,
    # destination account does not exist
    PAYMENT_NO_DESTINATION: -5,
    # destination missing a trust line for asset
    PAYMENT_NO_TRUST: -6,
    # destination not authorized to hold asset
    PAYMENT_NOT_AUTHORIZED: -7,
    # destination would go above their limit
    PAYMENT_LINE_FULL: -8,
    # missing issuer on asset
    PAYMENT_NO_ISSUER: -9
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
