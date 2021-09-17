defmodule Stellar.XDR.AlphaNum4 do
  @moduledoc """
  Representation of Stellar `AlphaNum4` type.
  """
  alias Stellar.XDR.{AccountID, AssetCode4}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(asset_code: AssetCode4, issuer: AccountID)

  @type t :: %__MODULE__{asset_code: AssetCode4.t(), issuer: AccountID.t()}

  defstruct [:asset_code, :issuer]

  @spec new(asset_code :: AssetCode4.t(), issuer :: AccountID.t()) :: t()
  def new(%AssetCode4{} = asset_code, %AccountID{} = issuer),
    do: %__MODULE__{asset_code: asset_code, issuer: issuer}

  @impl true
  def encode_xdr(%__MODULE__{asset_code: asset_code, issuer: issuer}) do
    [asset_code: asset_code, issuer: issuer]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{asset_code: asset_code, issuer: issuer}) do
    [asset_code: asset_code, issuer: issuer]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [asset_code: asset_code, issuer: issuer]}, rest}} ->
        {:ok, {new(asset_code, issuer), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [asset_code: asset_code, issuer: issuer]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(asset_code, issuer), rest}
  end
end
