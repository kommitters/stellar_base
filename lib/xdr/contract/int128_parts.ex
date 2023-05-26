defmodule StellarBase.XDR.Int128Parts do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `Int128Parts` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Int64,
    Uint64
  }

  @struct_spec XDR.Struct.new(
                 hi: Int64,
                 lo: Uint64
               )

  @type hi_type :: Int64.t()
  @type lo_type :: Uint64.t()

  @type t :: %__MODULE__{hi: hi_type(), lo: lo_type()}

  defstruct [:hi, :lo]

  @spec new(hi :: hi_type(), lo :: lo_type()) :: t()
  def new(
        %Int64{} = hi,
        %Uint64{} = lo
      ),
      do: %__MODULE__{hi: hi, lo: lo}

  @impl true
  def encode_xdr(%__MODULE__{hi: hi, lo: lo}) do
    [hi: hi, lo: lo]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{hi: hi, lo: lo}) do
    [hi: hi, lo: lo]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [hi: hi, lo: lo]}, rest}} ->
        {:ok, {new(hi, lo), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [hi: hi, lo: lo]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)
    {new(hi, lo), rest}
  end
end
