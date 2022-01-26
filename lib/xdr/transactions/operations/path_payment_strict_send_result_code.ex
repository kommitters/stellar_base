defmodule StellarBase.XDR.Operations.PathPaymentStrictSendResultCode do
  @moduledoc """
  Representation of Stellar `PathPaymentStrictSendResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # success
    PATH_PAYMENT_STRICT_SEND_SUCCESS: 0,
    # bad input
    PATH_PAYMENT_STRICT_SEND_MALFORMED: -1,
    # not enough funds in source account
    PATH_PAYMENT_STRICT_SEND_UNDERFUNDED: -2,
    # no trust line on source account
    PATH_PAYMENT_STRICT_SEND_SRC_NO_TRUST: -3,
    # source not authorized to transfer
    PATH_PAYMENT_STRICT_SEND_SRC_NOT_AUTHORIZED: -4,
    # destination account does not exist
    PATH_PAYMENT_STRICT_SEND_NO_DESTINATION: -5,
    # dest missing a trust line for asset
    PATH_PAYMENT_STRICT_SEND_NO_TRUST: -6,
    # dest not authorized to hold asset
    PATH_PAYMENT_STRICT_SEND_NOT_AUTHORIZED: -7,
    # dest would go above their limit
    PATH_PAYMENT_STRICT_SEND_LINE_FULL: -8,
    # missing issuer on one asset
    PATH_PAYMENT_STRICT_SEND_NO_ISSUER: -9,
    # not enough offers to satisfy path
    PATH_PAYMENT_STRICT_SEND_TOO_FEW_OFFERS: -10,
    # would cross one of its own offers
    PATH_PAYMENT_STRICT_SEND_OFFER_CROSS_SELF: -11,
    # could not satisfy destMin
    PATH_PAYMENT_STRICT_SEND_UNDER_DESTMIN: -12
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
