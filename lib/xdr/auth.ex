defmodule StellarBase.XDR.Auth do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `Auth` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.Int

  @struct_spec XDR.Struct.new(flags: Int)

  @type flags_type :: Int.t()

  @type t :: %__MODULE__{flags: flags_type()}

  defstruct [:flags]

  @spec new(flags :: flags_type()) :: t()
  def new(%Int{} = flags),
    do: %__MODULE__{flags: flags}

  @impl true
  def encode_xdr(%__MODULE__{flags: flags}) do
    [flags: flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{flags: flags}) do
    [flags: flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [flags: flags]}, rest}} ->
        {:ok, {new(flags), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [flags: flags]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)
    {new(flags), rest}
  end
end
