defmodule StellarBase.XDR.OptionalUInt32 do
  @moduledoc """
  Representation of Stellar `OptionalUInt32` type.
  """
  alias StellarBase.XDR.UInt32

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(UInt32)

  @type datum :: UInt32.t() | nil

  @type t :: %__MODULE__{datum: datum()}

  defstruct [:datum]

  @spec new(datum :: datum()) :: t()
  def new(datum \\ nil), do: %__MODULE__{datum: datum}

  @impl true
  def encode_xdr(%__MODULE__{datum: datum}) do
    datum
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{datum: datum}) do
    datum
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: datum}, rest}} ->
        {:ok, {new(datum), rest}}

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
      {%XDR.Optional{type: datum}, rest} -> {new(datum), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
