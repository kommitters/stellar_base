defmodule Stellar.XDR.Operations.ManageOfferSuccessResult do
  @moduledoc """
  Representation of Stellar `ManageOfferSuccessResult` type.
  """
  alias Stellar.XDR.ClaimAtomList
  alias Stellar.XDR.Operations.ManageOffer

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(offers_claimed: ClaimAtomList, offer: ManageOffer)

  @type t :: %__MODULE__{offers_claimed: ClaimAtomList.t(), offer: ManageOffer.t()}

  defstruct [:offers_claimed, :offer]

  @spec new(offers_claimed :: ClaimAtomList.t(), offer :: ManageOffer.t()) :: t()
  def new(%ClaimAtomList{} = offers_claimed, %ManageOffer{} = offer),
    do: %__MODULE__{offers_claimed: offers_claimed, offer: offer}

  @impl true
  def encode_xdr(%__MODULE__{offers_claimed: offers_claimed, offer: offer}) do
    [offers_claimed: offers_claimed, offer: offer]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{offers_claimed: offers_claimed, offer: offer}) do
    [offers_claimed: offers_claimed, offer: offer]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [offers_claimed: offers_claimed, offer: offer]}, rest}} ->
        {:ok, {new(offers_claimed, offer), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [offers_claimed: offers_claimed, offer: offer]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(offers_claimed, offer), rest}
  end
end
