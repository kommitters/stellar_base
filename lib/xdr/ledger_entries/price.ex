defmodule StellarBase.XDR.Price do
  @moduledoc """
  Representation of Stellar `Price` type.
  """
  alias StellarBase.XDR.Int32

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(numerator: Int32, denominator: Int32)

  @type t :: %__MODULE__{numerator: Int32.t(), denominator: Int32.t()}

  defstruct [:numerator, :denominator]

  @spec new(numerator :: Int32.t(), denominator :: Int32.t()) :: t()
  def new(%Int32{} = numerator, %Int32{} = denominator),
    do: %__MODULE__{numerator: numerator, denominator: denominator}

  @impl true
  def encode_xdr(%__MODULE__{numerator: numerator, denominator: denominator}) do
    [numerator: numerator, denominator: denominator]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{numerator: numerator, denominator: denominator}) do
    [numerator: numerator, denominator: denominator]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [numerator: numerator, denominator: denominator]}, rest}} ->
        {:ok, {new(numerator, denominator), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [numerator: numerator, denominator: denominator]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(numerator, denominator), rest}
  end
end
