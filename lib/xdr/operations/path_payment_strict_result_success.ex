defmodule Stellar.XDR.Operations.PathPaymentStrictResultSuccess do
  @moduledoc """
  Representation of Stellar `PathPaymentStrictResultSuccess` type.
  """
  alias Stellar.XDR.ClaimAtomList
  alias Stellar.XDR.Operations.SimplePaymentResult

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(offers: ClaimAtomList, last: SimplePaymentResult)

  @type t :: %__MODULE__{offers: ClaimAtomList.t(), last: SimplePaymentResult.t()}

  defstruct [:offers, :last]

  @spec new(offers :: ClaimAtomList.t(), last :: SimplePaymentResult.t()) :: t()
  def new(%ClaimAtomList{} = offers, %SimplePaymentResult{} = last),
    do: %__MODULE__{offers: offers, last: last}

  @impl true
  def encode_xdr(%__MODULE__{offers: offers, last: last}) do
    [offers: offers, last: last]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{offers: offers, last: last}) do
    [offers: offers, last: last]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [offers: offers, last: last]}, rest}} ->
        {:ok, {new(offers, last), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [offers: offers, last: last]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(offers, last), rest}
  end
end
