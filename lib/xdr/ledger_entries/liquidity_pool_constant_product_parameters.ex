defmodule StellarBase.XDR.LiquidityPoolConstantProductParameters do
  @moduledoc """
  Representation of Stellar `LiquidityPoolConstantProductParameters` type.
  """
  alias StellarBase.XDR.{Asset, Int32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(asset_a: Asset, asset_b: Asset, fee: Int32)

  @type t :: %__MODULE__{asset_a: Asset.t(), asset_b: Asset.t(), fee: Int32.t()}

  defstruct [:asset_a, :asset_b, :fee]

  @spec new(asset_a :: Asset.t(), asset_b :: Asset.t(), fee :: Int32.t()) :: t()
  def new(%Asset{} = asset_a, %Asset{} = asset_b, %Int32{} = fee),
    do: %__MODULE__{asset_a: asset_a, asset_b: asset_b, fee: fee}

  @impl true
  def encode_xdr(%__MODULE__{asset_a: asset_a, asset_b: asset_b, fee: fee}) do
    [asset_a: asset_a, asset_b: asset_b, fee: fee]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{asset_a: asset_a, asset_b: asset_b, fee: fee}) do
    [asset_a: asset_a, asset_b: asset_b, fee: fee]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [asset_a: asset_a, asset_b: asset_b, fee: fee]}, rest}} ->
        {:ok, {new(asset_a, asset_b, fee), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [asset_a: asset_a, asset_b: asset_b, fee: fee]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(asset_a, asset_b, fee), rest}
  end
end
