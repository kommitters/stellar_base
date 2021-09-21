defmodule Stellar.XDR.Operations.PathPaymentStrictSend do
  @moduledoc """
  Representation of Stellar `PathPaymentStrictSend` type.
  """
  alias Stellar.XDR.{Asset, Assets, Int64, MuxedAccount}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 send_asset: Asset,
                 send_amount: Int64,
                 destination: MuxedAccount,
                 dest_asset: Asset,
                 dest_min: Int64,
                 path: Assets
               )

  @type t :: %__MODULE__{
          send_asset: Asset.t(),
          send_amount: Int64.t(),
          destination: MuxedAccount.t(),
          dest_asset: Asset.t(),
          dest_min: Int64.t(),
          path: Assets.t()
        }

  defstruct [:send_asset, :send_amount, :destination, :dest_asset, :dest_min, :path]

  @spec new(
          send_asset :: Asset.t(),
          send_amount :: Int64.t(),
          destination :: MuxedAccount.t(),
          dest_asset :: Asset.t(),
          dest_min :: Int64.t(),
          path :: Assets.t()
        ) :: t()
  def new(
        %Asset{} = send_asset,
        %Int64{} = send_amount,
        %MuxedAccount{} = destination,
        %Asset{} = dest_asset,
        %Int64{} = dest_min,
        %Assets{} = path
      ),
      do: %__MODULE__{
        send_asset: send_asset,
        send_amount: send_amount,
        destination: destination,
        dest_asset: dest_asset,
        dest_min: dest_min,
        path: path
      }

  @impl true
  def encode_xdr(%__MODULE__{
        send_asset: send_asset,
        send_amount: send_amount,
        destination: destination,
        dest_asset: dest_asset,
        dest_min: dest_min,
        path: path
      }) do
    [
      send_asset: send_asset,
      send_amount: send_amount,
      destination: destination,
      dest_asset: dest_asset,
      dest_min: dest_min,
      path: path
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        send_asset: send_asset,
        send_amount: send_amount,
        destination: destination,
        dest_asset: dest_asset,
        dest_min: dest_min,
        path: path
      }) do
    [
      send_asset: send_asset,
      send_amount: send_amount,
      destination: destination,
      dest_asset: dest_asset,
      dest_min: dest_min,
      path: path
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
            send_asset: send_asset,
            send_amount: send_amount,
            destination: destination,
            dest_asset: dest_asset,
            dest_min: dest_min,
            path: path
          ]
        }, rest}} ->
        {:ok, {new(send_asset, send_amount, destination, dest_asset, dest_min, path), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         send_asset: send_asset,
         send_amount: send_amount,
         destination: destination,
         dest_asset: dest_asset,
         dest_min: dest_min,
         path: path
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(send_asset, send_amount, destination, dest_asset, dest_min, path), rest}
  end
end
