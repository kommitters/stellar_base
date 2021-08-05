defmodule Stellar.XDR.SequenceNumber do
  @moduledoc """
  Representation of Stellar `SequenceNumber` type.
  """
  alias Stellar.XDR.UInt64

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{sequence_number: non_neg_integer()}

  defstruct [:sequence_number]

  @spec new(sequence_number :: non_neg_integer()) :: t()
  def new(sequence_number), do: %__MODULE__{sequence_number: sequence_number}

  @impl true
  def encode_xdr(%__MODULE__{sequence_number: sequence_number}) do
    sequence_number
    |> UInt64.new()
    |> UInt64.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sequence_number: sequence_number}) do
    sequence_number
    |> UInt64.new()
    |> UInt64.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case UInt64.decode_xdr(bytes) do
      {:ok, {%UInt64{datum: seq_num}, rest}} -> {:ok, {new(seq_num), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%UInt64{datum: seq_num}, rest} = UInt64.decode_xdr!(bytes)
    {new(seq_num), rest}
  end
end
