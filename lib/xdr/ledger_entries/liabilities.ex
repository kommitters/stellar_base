defmodule StellarBase.XDR.Liabilities do
  @moduledoc """
  Representation of Stellar `Liabilities` type.
  """
  alias StellarBase.XDR.Int64

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(numerator: Int64, denominator: Int64)

  @type t :: %__MODULE__{buying: Int64.t(), selling: Int64.t()}

  defstruct [:buying, :selling]

  @spec new(buying :: Int64.t(), selling :: Int64.t()) :: t()
  def new(%Int64{} = buying, %Int64{} = selling),
    do: %__MODULE__{buying: buying, selling: selling}

  @impl true
  def encode_xdr(%__MODULE__{buying: buying, selling: selling}) do
    [buying: buying, selling: selling]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{buying: buying, selling: selling}) do
    [buying: buying, selling: selling]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [buying: buying, selling: selling]}, rest}} ->
        {:ok, {new(buying, selling), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [buying: buying, selling: selling]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(buying, selling), rest}
  end
end
