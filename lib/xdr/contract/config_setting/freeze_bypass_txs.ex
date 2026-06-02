defmodule StellarBase.XDR.FreezeBypassTxs do
  @moduledoc """
  Representation of Stellar `FreezeBypassTxs` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.HashList

  @struct_spec XDR.Struct.new(tx_hashes: HashList)

  @type tx_hashes_type :: HashList.t()

  @type t :: %__MODULE__{tx_hashes: tx_hashes_type()}

  defstruct [:tx_hashes]

  @spec new(tx_hashes :: tx_hashes_type()) :: t()
  def new(%HashList{} = tx_hashes),
    do: %__MODULE__{tx_hashes: tx_hashes}

  @impl true
  def encode_xdr(%__MODULE__{tx_hashes: tx_hashes}) do
    [tx_hashes: tx_hashes]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{tx_hashes: tx_hashes}) do
    [tx_hashes: tx_hashes]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [tx_hashes: tx_hashes]}, rest}} ->
        {:ok, {new(tx_hashes), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [tx_hashes: tx_hashes]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(tx_hashes), rest}
  end
end
