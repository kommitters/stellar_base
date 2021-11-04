defmodule StellarBase.XDR.Operations.ManageOffer do
  @moduledoc """
  Representation of Stellar `ManageOffer` type.
  """
  alias StellarBase.XDR.{OfferEntry, Void}
  alias StellarBase.XDR.Operations.ManageOfferEffect

  @behaviour XDR.Declaration

  @arms [
    MANAGE_OFFER_CREATED: OfferEntry,
    MANAGE_OFFER_UPDATED: OfferEntry,
    default: Void
  ]

  @type t :: %__MODULE__{offer: any(), effect: ManageOfferEffect.t()}

  defstruct [:offer, :effect]

  @spec new(offer :: any(), effect :: ManageOfferEffect.t()) :: t()
  def new(offer, %ManageOfferEffect{} = effect),
    do: %__MODULE__{offer: offer, effect: effect}

  @impl true
  def encode_xdr(%__MODULE__{offer: offer, effect: effect}) do
    effect
    |> XDR.Union.new(@arms, offer)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{offer: offer, effect: effect}) do
    effect
    |> XDR.Union.new(@arms, offer)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{effect, offer}, rest}} -> {:ok, {new(offer, effect), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{effect, offer}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(offer, effect), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> ManageOfferEffect.new()
    |> XDR.Union.new(@arms)
  end
end
