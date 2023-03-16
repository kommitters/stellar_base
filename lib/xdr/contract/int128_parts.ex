defmodule StellarBase.XDR.Int128Parts do
  @moduledoc """
  Representation of Stellar `Int128Parts` type.
  """

  alias StellarBase.XDR.{UInt64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(lo: UInt64, hi: UInt64)

  @type t :: %__MODULE__{lo: UInt64.t(), hi: UInt64.t()}

  defstruct [:lo, :hi]

  @spec new(lo :: UInt64.t(), hi :: UInt64.t()) :: t()
  def new(%UInt64{} = lo, %UInt64{} = hi), do: %__MODULE__{lo: lo, hi: hi}

  @impl true
  def encode_xdr(%__MODULE__{lo: lo, hi: hi}) do
    [lo: lo, hi: hi]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{lo: lo, hi: hi}) do
    [lo: lo, hi: hi]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [lo: lo, hi: hi]}, rest}} ->
        {:ok, {new(lo, hi), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [lo: lo, hi: hi]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(lo, hi), rest}
  end
end
