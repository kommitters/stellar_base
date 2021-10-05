defmodule Stellar.XDR.LiquidityPoolParameters do
  @moduledoc """
  Representation of Stellar `LiquidityPoolParameters` type.
  """
  alias Stellar.XDR.LiquidityPoolType
  alias Stellar.XDR.LiquidityPoolConstantProductParameters, as: LiquidityPoolConstant

  @behaviour XDR.Declaration

  @arms [LIQUIDITY_POOL_CONSTANT_PRODUCT: LiquidityPoolConstant]

  @type product :: LiquidityPoolConstant.t()

  @type t :: %__MODULE__{product: LiquidityPoolConstant.t(), type: LiquidityPoolType.t()}

  defstruct [:product, :type]

  @spec new(product :: LiquidityPoolConstant.t(), type :: LiquidityPoolType.t()) :: t()
  def new(%LiquidityPoolConstant{} = product, %LiquidityPoolType{} = type),
    do: %__MODULE__{product: product, type: type}

  @impl true
  def encode_xdr(%__MODULE__{product: product, type: type}) do
    type
    |> XDR.Union.new(@arms, product)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{product: product, type: type}) do
    type
    |> XDR.Union.new(@arms, product)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, product}, rest}} -> {:ok, {new(product, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, product}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(product, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> LiquidityPoolType.new()
    |> XDR.Union.new(@arms)
  end
end
