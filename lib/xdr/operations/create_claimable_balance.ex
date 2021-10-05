defmodule Stellar.XDR.Operations.CreateClaimableBalance do
  @moduledoc """
  Representation of Stellar `CreateClaimableBalance` type.
  """
  alias Stellar.XDR.{Asset, Int64, Claimants}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(asset: Asset, amount: Int64, claimants: Claimants)

  @type t :: %__MODULE__{asset: Asset.t(), amount: Int64.t(), claimants: Claimants.t()}

  defstruct [:asset, :amount, :claimants]

  @spec new(asset :: Asset.t(), amount :: Int64.t(), claimants :: Claimants.t()) :: t()
  def new(%Asset{} = asset, %Int64{} = amount, %Claimants{} = claimants),
    do: %__MODULE__{asset: asset, amount: amount, claimants: claimants}

  @impl true
  def encode_xdr(%__MODULE__{asset: asset, amount: amount, claimants: claimants}) do
    [asset: asset, amount: amount, claimants: claimants]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{asset: asset, amount: amount, claimants: claimants}) do
    [asset: asset, amount: amount, claimants: claimants]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [asset: asset, amount: amount, claimants: claimants]}, rest}} ->
        {:ok, {new(asset, amount, claimants), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [asset: asset, amount: amount, claimants: claimants]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(asset, amount, claimants), rest}
  end
end
