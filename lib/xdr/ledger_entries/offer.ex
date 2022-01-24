defmodule StellarBase.XDR.Offer do
  @moduledoc """
  Representation of Stellar `Offer` type.
  """
  alias StellarBase.XDR.{AccountID, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(seller_id: AccountID, offer_id: Int64)

  @type t :: %__MODULE__{seller_id: AccountID.t(), offer_id: Int64.t()}

  defstruct [:seller_id, :offer_id]

  @spec new(seller_id :: AccountID.t(), offer_id :: Int64.t()) :: t()
  def new(%AccountID{} = seller_id, %Int64{} = offer_id),
    do: %__MODULE__{seller_id: seller_id, offer_id: offer_id}

  @impl true
  def encode_xdr(%__MODULE__{seller_id: seller_id, offer_id: offer_id}) do
    [seller_id: seller_id, offer_id: offer_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{seller_id: seller_id, offer_id: offer_id}) do
    [seller_id: seller_id, offer_id: offer_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [seller_id: seller_id, offer_id: offer_id]}, rest}} ->
        {:ok, {new(seller_id, offer_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [seller_id: seller_id, offer_id: offer_id]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(seller_id, offer_id), rest}
  end
end
