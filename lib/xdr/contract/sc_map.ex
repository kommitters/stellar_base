defmodule StellarBase.XDR.SCMap do
  @moduledoc """
  Representation of a Stellar `SCMap` list.
  """

  alias StellarBase.XDR.SCMapEntry

  @behaviour XDR.Declaration

  @max_length 256_000

  @array_type SCMapEntry

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{scmap_entries: list(SCMapEntry.t())}

  defstruct [:scmap_entries]

  @spec new(scmap_entries :: list(SCMapEntry.t())) :: t()
  def new(scmap_entries), do: %__MODULE__{scmap_entries: scmap_entries}

  @impl true
  def encode_xdr(%__MODULE__{scmap_entries: scmap_entries}) do
    scmap_entries
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{scmap_entries: scmap_entries}) do
    scmap_entries
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {scmap_entries, rest}} -> {:ok, {new(scmap_entries), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {scmap_entries, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(scmap_entries), rest}
  end
end
