defmodule StellarBase.XDR.OptionalAccountID do
  @moduledoc """
  Representation of Stellar `OptionalAccountID` type.
  """
  alias StellarBase.XDR.AccountID

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(AccountID)

  @type account_id :: AccountID.t() | nil

  @type t :: %__MODULE__{account_id: account_id()}

  defstruct [:account_id]

  @spec new(account_id :: account_id()) :: t()
  def new(account_id \\ nil), do: %__MODULE__{account_id: account_id}

  @impl true
  def encode_xdr(%__MODULE__{account_id: account_id}) do
    account_id
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{account_id: account_id}) do
    account_id
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: account_id}, rest}} ->
        {:ok, {new(account_id), rest}}

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
      {%XDR.Optional{type: account_id}, rest} -> {new(account_id), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
