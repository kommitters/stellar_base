defmodule StellarBase.XDR.SCSpecTypeBytesN do
  @moduledoc """
  Representation of Stellar `SCSpecTypeBytesN` type.
  """
  alias StellarBase.XDR.UInt32

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(number: UInt32)

  @type t :: %__MODULE__{number: UInt32.t()}

  defstruct [:number]

  @spec new(number :: UInt32.t()) :: t()
  def new(%UInt32{} = number),
    do: %__MODULE__{number: number}

  @impl true
  def encode_xdr(%__MODULE__{number: number}) do
    [number: number]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{number: number}) do
    [number: number]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [number: number]}, rest}} ->
        {:ok, {new(number), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [number: number]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(number), rest}
  end
end
