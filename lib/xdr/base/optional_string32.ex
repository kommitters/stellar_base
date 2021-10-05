defmodule Stellar.XDR.OptionalString32 do
  @moduledoc """
  Representation of Stellar `OptionalString32` type.
  """
  alias Stellar.XDR.String32

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(String32)

  @type value :: String32.t() | nil

  @type t :: %__MODULE__{value: value()}

  defstruct [:value]

  @spec new(value :: value()) :: t()
  def new(value \\ nil), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    value
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    value
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: value}, rest}} ->
        {:ok, {new(value), rest}}

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
      {%XDR.Optional{type: value}, rest} -> {new(value), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
