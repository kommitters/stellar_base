defmodule StellarBase.XDR.Operations.ManageSellOfferResultCode do
  @moduledoc """
  Representation of Stellar `ManageSellOfferResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # success
    MANAGE_SELL_OFFER_SUCCESS: 0,
    # generated offer would be invalid
    MANAGE_SELL_OFFER_MALFORMED: -1,
    # no trust line for what we're selling
    MANAGE_SELL_OFFER_SELL_NO_TRUST: -2,
    # no trust line for what we're buying
    MANAGE_SELL_OFFER_BUY_NO_TRUST: -3,
    # not authorized to sell
    MANAGE_SELL_OFFER_SELL_NOT_AUTHORIZED: -4,
    # not authorized to buy
    MANAGE_SELL_OFFER_BUY_NOT_AUTHORIZED: -5,
    # can't receive more of what it's buying
    MANAGE_SELL_OFFER_LINE_FULL: -6,
    # doesn't hold what it's trying to sell
    MANAGE_SELL_OFFER_UNDERFUNDED: -7,
    # would cross an offer from the same user
    MANAGE_SELL_OFFER_CROSS_SELF: -8,
    # no issuer for what we're selling
    MANAGE_SELL_OFFER_SELL_NO_ISSUER: -9,
    # no issuer for what we're buying
    MANAGE_SELL_OFFER_BUY_NO_ISSUER: -10,
    # offerID does not match an existing offer
    MANAGE_SELL_OFFER_NOT_FOUND: -11,
    # not enough funds to create a new Offer
    MANAGE_SELL_OFFER_LOW_RESERVE: -12
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
