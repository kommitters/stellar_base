defmodule Stellar.XDR.ClaimantV0 do
  @moduledoc """
  Representation of Stellar `ClaimantV0` type.
  """
  alias Stellar.XDR.{AccountID, ClaimPredicate}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(destination: AccountID, predicate: ClaimPredicate)

  @type t :: %__MODULE__{destination: AccountID.t(), predicate: ClaimPredicate.t()}

  defstruct [:destination, :predicate]

  @spec new(destination :: AccountID.t(), predicate :: ClaimPredicate.t()) :: t()
  def new(%AccountID{} = destination, %ClaimPredicate{} = predicate),
    do: %__MODULE__{destination: destination, predicate: predicate}

  @impl true
  def encode_xdr(%__MODULE__{destination: destination, predicate: predicate}) do
    [destination: destination, predicate: predicate]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{destination: destination, predicate: predicate}) do
    [destination: destination, predicate: predicate]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [destination: destination, predicate: predicate]}, rest}} ->
        {:ok, {new(destination, predicate), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [destination: destination, predicate: predicate]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(destination, predicate), rest}
  end
end
