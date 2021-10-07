defmodule Stellar.XDR.TransactionV1Envelope do
  @moduledoc """
  Representation of Stellar `TransactionV1Envelope` type.
  """
  alias Stellar.XDR.{DecoratedSignatures, Transaction}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(tx: Transaction, signatures: DecoratedSignatures)

  @type t :: %__MODULE__{tx: Transaction.t(), signatures: DecoratedSignatures.t()}

  defstruct [:tx, :signatures]

  @spec new(tx :: Transaction.t(), signatures :: DecoratedSignatures.t()) :: t()
  def new(%Transaction{} = tx, %DecoratedSignatures{} = signatures),
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
