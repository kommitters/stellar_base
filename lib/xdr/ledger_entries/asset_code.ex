defmodule StellarBase.XDR.AssetCode do
  @moduledoc """
  Representation of Stellar `AssetCode` type.
  """
  alias StellarBase.XDR.{AssetCode4, AssetCode12, AssetType}

  @behaviour XDR.Declaration

  @arms [
    ASSET_TYPE_CREDIT_ALPHANUM4: AssetCode4,
    ASSET_TYPE_CREDIT_ALPHANUM12: AssetCode12
  ]

  @type asset_code :: AssetCode4.t() | AssetCode12.t()

  @type t :: %__MODULE__{asset: asset_code(), type: AssetType.t()}

  defstruct [:asset, :type]

  @spec new(asset :: asset_code(), type :: AssetType.t()) :: t()
  def new(asset, %AssetType{} = type), do: %__MODULE__{asset: asset, type: type}

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
