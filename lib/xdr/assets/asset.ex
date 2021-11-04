defmodule StellarBase.XDR.Asset do
  @moduledoc """
  Representation of Stellar `Asset` type.
  """
  alias StellarBase.XDR.{AlphaNum4, AlphaNum12, AssetType, Void}

  @behaviour XDR.Declaration

  @arms [
    ASSET_TYPE_NATIVE: Void,
    ASSET_TYPE_CREDIT_ALPHANUM4: AlphaNum4,
    ASSET_TYPE_CREDIT_ALPHANUM12: AlphaNum12
  ]

  @type asset :: AlphaNum4.t() | AlphaNum12.t() | Void.t()

  @type t :: %__MODULE__{asset: asset(), type: AssetType.t()}

  defstruct [:asset, :type]

  @spec new(asset :: asset(), type :: AssetType.t()) :: t()
  def new(asset, %AssetType{} = type),
    do: %__MODULE__{asset: asset, type: type}

  @impl true
  def encode_xdr(%__MODULE__{asset: asset, type: type}) do
    type
    |> XDR.Union.new(@arms, asset)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{asset: asset, type: type}) do
    type
    |> XDR.Union.new(@arms, asset)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, asset}, rest}} -> {:ok, {new(asset, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, asset}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(asset, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> AssetType.new()
    |> XDR.Union.new(@arms)
  end
end
