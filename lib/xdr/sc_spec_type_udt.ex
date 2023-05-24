defmodule StellarBase.XDR.SCSpecTypeUDT do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SCSpecTypeUDT` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.String60

  @struct_spec XDR.Struct.new(name: String60)

  @type name_type :: String60.t()

  @type t :: %__MODULE__{name: name_type()}

  defstruct [:name]

  @spec new(name :: name_type()) :: t()
  def new(%String60{} = name),
    do: %__MODULE__{name: name}

  @impl true
  def encode_xdr(%__MODULE__{name: name}) do
    [name: name]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{name: name}) do
    [name: name]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [name: name]}, rest}} ->
        {:ok, {new(name), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [name: name]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)
    {new(name), rest}
  end
end
