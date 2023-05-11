defmodule StellarBase.XDR.LedgerBounds do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `LedgerBounds` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Uint32
  }

  @struct_spec XDR.Struct.new(
    min_ledger: Uint32,
    max_ledger: Uint32
  )

  @type type_min_ledger :: Uint32.t()
  @type type_max_ledger :: Uint32.t()

  @type t :: %__MODULE__{min_ledger: type_min_ledger(), max_ledger: type_max_ledger()}

  defstruct [:min_ledger, :max_ledger]

  @spec new(min_ledger :: type_min_ledger(), max_ledger :: type_max_ledger()) :: t()
  def new(
    %Uint32{} = min_ledger,
    %Uint32{} = max_ledger
  ),
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
      error -> error
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
