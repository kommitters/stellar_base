defmodule StellarBase.XDR.Operations.ChangeTrust do
  @moduledoc """
  Representation of Stellar `ChangeTrust` type.
  """
  alias StellarBase.XDR.{ChangeTrustAsset, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(asset: ChangeTrustAsset, limit: Int64)

  @type t :: %__MODULE__{asset: ChangeTrustAsset.t(), limit: Int64.t()}

  defstruct [:asset, :limit]

  @spec new(asset :: ChangeTrustAsset.t(), limit :: Int64.t()) :: t()
  def new(%ChangeTrustAsset{} = asset, %Int64{} = limit),
    do: %__MODULE__{asset: asset, limit: limit}

  @impl true
  def encode_xdr(%__MODULE__{asset: asset, limit: limit}) do
    [asset: asset, limit: limit]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{asset: asset, limit: limit}) do
    [asset: asset, limit: limit]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [asset: asset, limit: limit]}, rest}} ->
        {:ok, {new(asset, limit), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [asset: asset, limit: limit]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(asset, limit), rest}
  end
end
