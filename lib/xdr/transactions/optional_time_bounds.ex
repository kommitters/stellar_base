defmodule Stellar.XDR.OptionalTimeBounds do
  @moduledoc """
  Representation of Stellar `OptionalTimeBounds` type.
  """
  alias Stellar.XDR.{TimeBounds, Void}

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(TimeBounds)

  @type t :: %__MODULE__{time_bounds: TimeBounds.t()}

  defstruct [:time_bounds]

  @spec new(time_bounds :: TimeBounds.t()) :: t()
  def new(%TimeBounds{} = time_bounds), do: %__MODULE__{time_bounds: time_bounds}

  @impl true
  def encode_xdr(%__MODULE__{time_bounds: time_bounds}) do
    time_bounds
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{time_bounds: time_bounds}) do
    time_bounds
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: time_bounds}, rest}} ->
        {:ok, {new(time_bounds), rest}}

      {:ok, {nil, rest}} ->
        {:ok, {Void.new(), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, optional_spec \\ @optional_spec)

  def decode_xdr!(bytes, optional_spec) do
    case XDR.Optional.decode_xdr!(bytes, optional_spec) do
      {%XDR.Optional{type: time_bounds}, rest} -> {new(time_bounds), rest}
      {nil, rest} -> {Void.new(), rest}
    end
  end
end
