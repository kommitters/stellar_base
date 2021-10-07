defmodule Stellar.XDR.TransactionV0Envelope do
  @moduledoc """
  Representation of Stellar `TransactionV0Envelope` type.
  """
  alias Stellar.XDR.{DecoratedSignatures, TransactionV0}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(tx: TransactionV0, signatures: DecoratedSignatures)

  @type t :: %__MODULE__{tx: TransactionV0.t(), signatures: DecoratedSignatures.t()}

  defstruct [:tx, :signatures]

  @spec new(tx :: TransactionV0.t(), signatures :: DecoratedSignatures.t()) :: t()
  def new(%TransactionV0{} = tx, %DecoratedSignatures{} = signatures),
    do: %__MODULE__{tx: tx, signatures: signatures}

  @impl true
  def encode_xdr(%__MODULE__{tx: tx, signatures: signatures}) do
    [tx: tx, signatures: signatures]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{tx: tx, signatures: signatures}) do
    [tx: tx, signatures: signatures]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [tx: tx, signatures: signatures]}, rest}} ->
        {:ok, {new(tx, signatures), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [tx: tx, signatures: signatures]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(tx, signatures), rest}
  end
end
