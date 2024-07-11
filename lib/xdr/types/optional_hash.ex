defmodule StellarBase.XDR.OptionalHash do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `OptionalHash` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.Hash

  @optional_spec XDR.Optional.new(Hash)

  @type hash :: Hash.t() | nil

  @type t :: %__MODULE__{hash: hash()}

  defstruct [:hash]

  @spec new(hash :: hash()) :: t()
  def new(hash \\ nil), do: %__MODULE__{hash: hash}

  @impl true
  def encode_xdr(%__MODULE__{hash: hash}) do
    hash
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{hash: hash}) do
    hash
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: hash}, rest}} -> {:ok, {new(hash), rest}}
      {:ok, {nil, rest}} -> {:ok, {new(), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, optional_spec \\ @optional_spec)

  def decode_xdr!(bytes, optional_spec) do
    case XDR.Optional.decode_xdr!(bytes, optional_spec) do
      {%XDR.Optional{type: hash}, rest} -> {new(hash), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end