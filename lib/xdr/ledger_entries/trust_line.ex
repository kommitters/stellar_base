defmodule StellarBase.XDR.TrustLine do
  @moduledoc """
  Representation of Stellar `TrustLine` type.
  """
  alias StellarBase.XDR.{AccountID, TrustLineAsset}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(account_id: AccountID, asset: TrustLineAsset)

  @type t :: %__MODULE__{account_id: AccountID.t(), asset: TrustLineAsset.t()}

  defstruct [:account_id, :asset]

  @spec new(account_id :: AccountID.t(), asset :: TrustLineAsset.t()) :: t()
  def new(%AccountID{} = account_id, %TrustLineAsset{} = asset),
    do: %__MODULE__{account_id: account_id, asset: asset}

  @impl true
  def encode_xdr(%__MODULE__{account_id: account_id, asset: asset}) do
    [account_id: account_id, asset: asset]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{account_id: account_id, asset: asset}) do
    [account_id: account_id, asset: asset]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [account_id: account_id, asset: asset]}, rest}} ->
        {:ok, {new(account_id, asset), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [account_id: account_id, asset: asset]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(account_id, asset), rest}
  end
end
