defmodule StellarBase.XDR.FromAsset do
  @moduledoc """
  Representation of Stellar `FromAsset` type.
  """
  alias StellarBase.XDR.{Hash, Asset}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 network_id: Hash,
                 asset: Asset
               )

  @type t :: %__MODULE__{
          network_id: Hash.t(),
          asset: Asset.t()
        }

  defstruct [:network_id, :asset]

  @spec new(
          network_id :: Hash.t(),
          asset :: Asset.t()
        ) :: t()
  def new(
        %Hash{} = network_id,
        %Asset{} = asset
      ) do
    %__MODULE__{
      network_id: network_id,
      asset: asset
    }
  end

  @impl true
  def encode_xdr(%__MODULE__{
        network_id: network_id,
        asset: asset
      }) do
    [
      network_id: network_id,
      asset: asset
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        network_id: network_id,
        asset: asset
      }) do
    [
      network_id: network_id,
      asset: asset
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            network_id: network_id,
            asset: asset
          ]
        }, rest}} ->
        {:ok, {new(network_id, asset), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         network_id: network_id,
         asset: asset
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(network_id, asset), rest}
  end
end
