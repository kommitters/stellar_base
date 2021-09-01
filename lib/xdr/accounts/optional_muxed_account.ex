defmodule Stellar.XDR.OptionalMuxedAccount do
  @moduledoc """
  Representation of Stellar `OptionalMuxedAccount` type.
  """
  alias Stellar.XDR.MuxedAccount

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(MuxedAccount)

  @type source_account :: MuxedAccount.t() | nil

  @type t :: %__MODULE__{source_account: source_account()}

  defstruct [:source_account]

  @spec new(source_account :: source_account()) :: t()
  def new(source_account \\ nil), do: %__MODULE__{source_account: source_account}

  @impl true
  def encode_xdr(%__MODULE__{source_account: source_account}) do
    source_account
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{source_account: source_account}) do
    source_account
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: source_account}, rest}} ->
        {:ok, {new(source_account), rest}}

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
      {%XDR.Optional{type: source_account}, rest} -> {new(source_account), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
