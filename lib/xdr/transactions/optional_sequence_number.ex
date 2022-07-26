defmodule StellarBase.XDR.OptionalSequenceNumber do
  @moduledoc """
  Representation of Stellar `OptionalSequenceNumber` type.
  """
  alias StellarBase.XDR.SequenceNumber

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(SequenceNumber)

  @type sequence_number :: SequenceNumber.t() | nil

  @type t :: %__MODULE__{sequence_number: sequence_number()}

  defstruct [:sequence_number]

  @spec new(sequence_number :: sequence_number()) :: t()
  def new(sequence_number \\ nil), do: %__MODULE__{sequence_number: sequence_number}

  @impl true
  def encode_xdr(%__MODULE__{sequence_number: sequence_number}) do
    sequence_number
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sequence_number: sequence_number}) do
    sequence_number
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: sequence_number}, rest}} ->
        {:ok, {new(sequence_number), rest}}

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
      {%XDR.Optional{type: sequence_number}, rest} -> {new(sequence_number), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
