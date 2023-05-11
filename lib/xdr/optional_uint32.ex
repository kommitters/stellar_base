defmodule StellarBase.XDR.OptionalUint32 do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `OptionalUint32` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.Uint32

  @optional_spec XDR.Optional.new(Uint32)

  @type uint32 :: Uint32.t() | nil

  @type t :: %__MODULE__{uint32: uint32()}

  defstruct [:uint32]

  @spec new(uint32 :: uint32()) :: t()
  def new(uint32 \\ nil), do: %__MODULE__{uint32: uint32}

  @impl true
  def encode_xdr(%__MODULE__{uint32: uint32}) do
    uint32
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{uint32: uint32}) do
    uint32
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: uint32}, rest}} -> {:ok, {new(uint32), rest}}
      {:ok, {nil, rest}} -> {:ok, {new(), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, optional_spec \\ @optional_spec)

  def decode_xdr!(bytes, optional_spec) do
    case XDR.Optional.decode_xdr!(bytes, optional_spec) do
      {%XDR.Optional{type: uint32}, rest} -> {new(uint32), rest}
      {nil, rest} -> {new(), rest}
    end
  end

end
