defmodule StellarBase.XDR.LedgerKeyList do
  @moduledoc """
  Representation of a Stellar `LedgerKeyList` list.
  """
  alias StellarBase.XDR.LedgerKey

  @behaviour XDR.Declaration

  @max_length 4_294_967_295

  @array_type LedgerKey

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{ledger_keys: list(LedgerKey.t())}

  defstruct [:ledger_keys]

  @spec new(ledger_keys :: list(LedgerKey.t())) :: t()
  def new(ledger_keys), do: %__MODULE__{ledger_keys: ledger_keys}

  @impl true
  def encode_xdr(%__MODULE__{ledger_keys: ledger_keys}) do
    ledger_keys
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ledger_keys: ledger_keys}) do
    ledger_keys
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {ledger_keys, rest}} -> {:ok, {new(ledger_keys), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {ledger_keys, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(ledger_keys), rest}
  end
end
