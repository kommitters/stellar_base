defmodule StellarBase.XDR.OptionalAddressWithNonce do
  @moduledoc """
  Representation of Stellar `OptionalAddressWithNonce` type.
  """
  alias StellarBase.XDR.AddressWithNonce

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(AddressWithNonce)

  @type address_with_nonce :: AddressWithNonce.t() | nil

  @type t :: %__MODULE__{address_with_nonce: address_with_nonce()}

  defstruct [:address_with_nonce]

  @spec new(address_with_nonce :: address_with_nonce()) :: t()
  def new(address_with_nonce \\ nil), do: %__MODULE__{address_with_nonce: address_with_nonce}

  @impl true
  def encode_xdr(%__MODULE__{address_with_nonce: address_with_nonce}) do
    address_with_nonce
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{address_with_nonce: address_with_nonce}) do
    address_with_nonce
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: address_with_nonce}, rest}} ->
        {:ok, {new(address_with_nonce), rest}}

      {:ok, {nil, rest}} ->
        {:ok, {new(), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, optional_spec \\ @optional_spec)

  def decode_xdr!(bytes, optional_spec) do
    case XDR.Optional.decode_xdr!(bytes, optional_spec) do
      {%XDR.Optional{type: address_with_nonce}, rest} -> {new(address_with_nonce), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
