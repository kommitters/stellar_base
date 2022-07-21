defmodule StellarBase.XDR.LedgerBounds do
  @moduledoc """
  Representation of Stellar `LedgerBounds` type.
  """
  alias StellarBase.XDR.UInt32

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(min_ledger: UInt32, max_ledger: UInt32)

  @type t :: %__MODULE__{min_ledger: UInt32.t(), max_ledger: UInt32.t()}

  defstruct [:min_ledger, :max_ledger]

  @spec new(min_ledger :: UInt32.t(), max_ledger :: UInt32.t()) :: t()
  def new(%UInt32{} = min_ledger, %UInt32{} = max_ledger),
    do: %__MODULE__{min_ledger: min_ledger, max_ledger: max_ledger}

  @impl true
  def encode_xdr(%__MODULE__{min_ledger: min_ledger, max_ledger: max_ledger}) do
    [min_ledger: min_ledger, max_ledger: max_ledger]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{min_ledger: min_ledger, max_ledger: max_ledger}) do
    [min_ledger: min_ledger, max_ledger: max_ledger]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [min_ledger: min_ledger, max_ledger: max_ledger]}, rest}} ->
        {:ok, {new(min_ledger, max_ledger), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [min_ledger: min_ledger, max_ledger: max_ledger]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(min_ledger, max_ledger), rest}
  end
end
