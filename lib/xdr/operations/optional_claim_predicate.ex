defmodule StellarBase.XDR.OptionalClaimPredicate do
  @moduledoc """
  Representation of Stellar `OptionalClaimPredicate` type.
  """
  alias StellarBase.XDR.ClaimPredicate

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(ClaimPredicate)

  @type predicate :: ClaimPredicate.t() | nil

  @type t :: %__MODULE__{predicate: predicate()}

  defstruct [:predicate]

  @spec new(predicate :: predicate()) :: t()
  def new(predicate \\ nil), do: %__MODULE__{predicate: predicate}

  @impl true
  def encode_xdr(%__MODULE__{predicate: predicate}) do
    predicate
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{predicate: predicate}) do
    predicate
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: predicate}, rest}} ->
        {:ok, {new(predicate), rest}}

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
      {%XDR.Optional{type: predicate}, rest} -> {new(predicate), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
