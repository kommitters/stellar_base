defmodule StellarBase.XDR.LedgerFootprint do
  @moduledoc """
  Representation of Stellar `LedgerFootprint` type.
  """
  alias StellarBase.XDR.LedgerKeyList

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(read_only: LedgerKeyList, read_write: LedgerKeyList)

  @type t :: %__MODULE__{read_only: LedgerKeyList.t(), read_write: LedgerKeyList.t()}

  defstruct [:read_only, :read_write]

  @spec new(read_only :: LedgerKeyList.t(), read_write :: LedgerKeyList.t()) :: t()
  def new(%LedgerKeyList{} = read_only, %LedgerKeyList{} = read_write),
    do: %__MODULE__{read_only: read_only, read_write: read_write}

  @impl true
  def encode_xdr(%__MODULE__{read_only: read_only, read_write: read_write}) do
    [read_only: read_only, read_write: read_write]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{read_only: read_only, read_write: read_write}) do
    [read_only: read_only, read_write: read_write]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [read_only: read_only, read_write: read_write]}, rest}} ->
        {:ok, {new(read_only, read_write), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [read_only: read_only, read_write: read_write]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(read_only, read_write), rest}
  end
end
