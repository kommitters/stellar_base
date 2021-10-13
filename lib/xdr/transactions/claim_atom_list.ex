defmodule Stellar.XDR.ClaimAtomList do
  @moduledoc """
  Representation of a Stellar `ClaimAtomList` list.
  """
  alias Stellar.XDR.ClaimAtom

  @behaviour XDR.Declaration

  @max_length 100

  @array_type ClaimAtom

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{offers: list(ClaimAtom.t())}

  defstruct [:offers]

  @spec new(offers :: list(ClaimAtom.t())) :: t()
  def new(offers), do: %__MODULE__{offers: offers}

  @impl true
  def encode_xdr(%__MODULE__{offers: offers}) do
    offers
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{offers: offers}) do
    offers
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {offers, rest}} -> {:ok, {new(offers), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {offers, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(offers), rest}
  end
end
