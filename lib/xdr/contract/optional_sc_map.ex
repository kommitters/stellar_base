defmodule StellarBase.XDR.OptionalSCMap do
  @moduledoc """
  Representation of Stellar `OptionalSCMap` type.
  """

  alias StellarBase.XDR.SCMap

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(SCMap)

  @type sc_map :: SCMap.t() | nil

  @type t :: %__MODULE__{sc_map: sc_map()}

  defstruct [:sc_map]

  @spec new(sc_map :: sc_map()) :: t()
  def new(sc_map \\ nil), do: %__MODULE__{sc_map: sc_map}

  @impl true
  def encode_xdr(%__MODULE__{sc_map: sc_map}) do
    sc_map
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_map: sc_map}) do
    sc_map
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: sc_map}, rest}} ->
        {:ok, {new(sc_map), rest}}

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
      {%XDR.Optional{type: sc_map}, rest} -> {new(sc_map), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
