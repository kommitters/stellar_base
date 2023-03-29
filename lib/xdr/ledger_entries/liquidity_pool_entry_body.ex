defmodule StellarBase.XDR.LiquidityPoolEntryBody do
  @moduledoc """
  Representation of Stellar `LiquidityPoolEntryBody` type.
  """

  alias StellarBase.XDR.{ConstantProduct, LiquidityPoolType}

  @behaviour XDR.Declaration

  @arms [LIQUIDITY_POOL_CONSTANT_PRODUCT: ConstantProduct]

  @type entry :: ConstantProduct.t()

  @type t :: %__MODULE__{entry: entry(), type: LiquidityPoolType.t()}

  defstruct [:entry, :type]

  @spec new(entry :: entry(), type :: LiquidityPoolType.t()) :: t()
  def new(entry, %LiquidityPoolType{} = type), do: %__MODULE__{entry: entry, type: type}

  @impl true
  def encode_xdr(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, key}, rest}} -> {:ok, {new(key, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, key}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(key, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> LiquidityPoolType.new()
    |> XDR.Union.new(@arms)
  end
end
