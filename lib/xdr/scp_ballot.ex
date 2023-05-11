defmodule StellarBase.XDR.SCPBallot do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SCPBallot` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Uint32,
    Value
  }

  @struct_spec XDR.Struct.new(
    counter: Uint32,
    value: Value
  )

  @type type_counter :: Uint32.t()
  @type type_value :: Value.t()

  @type t :: %__MODULE__{counter: type_counter(), value: type_value()}

  defstruct [:counter, :value]

  @spec new(counter :: type_counter(), value :: type_value()) :: t()
  def new(
    %Uint32{} = counter,
    %Value{} = value
  ),
  do: %__MODULE__{counter: counter, value: value}

  @impl true
  def encode_xdr(%__MODULE__{counter: counter, value: value}) do
    [counter: counter, value: value]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{counter: counter, value: value}) do
    [counter: counter, value: value]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [counter: counter, value: value]}, rest}} ->
        {:ok, {new(counter, value), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [counter: counter, value: value]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(counter, value), rest}
  end
end
