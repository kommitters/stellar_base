defmodule StellarBase.XDR.OptionalLedgerBounds do
  @moduledoc """
  Representation of Stellar `OptionalLedgerBounds` type.
  """
  alias StellarBase.XDR.LedgerBounds

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(LedgerBounds)

  @type ledger_bounds :: LedgerBounds.t() | nil

  @type t :: %__MODULE__{ledger_bounds: ledger_bounds()}

  defstruct [:ledger_bounds]

  @spec new(ledger_bounds :: ledger_bounds()) :: t()
  def new(ledger_bounds \\ nil), do: %__MODULE__{ledger_bounds: ledger_bounds}

  @impl true
  def encode_xdr(%__MODULE__{ledger_bounds: ledger_bounds}) do
    ledger_bounds
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ledger_bounds: ledger_bounds}) do
    ledger_bounds
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: ledger_bounds}, rest}} ->
        {:ok, {new(ledger_bounds), rest}}

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
      {%XDR.Optional{type: ledger_bounds}, rest} -> {new(ledger_bounds), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
