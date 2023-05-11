defmodule StellarBase.XDR.PaymentOp do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `PaymentOp` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    MuxedAccount,
    Asset,
    Int64
  }

  @struct_spec XDR.Struct.new(
    destination: MuxedAccount,
    asset: Asset,
    amount: Int64
  )

  @type type_destination :: MuxedAccount.t()
  @type type_asset :: Asset.t()
  @type type_amount :: Int64.t()

  @type t :: %__MODULE__{destination: type_destination(), asset: type_asset(), amount: type_amount()}

  defstruct [:destination, :asset, :amount]

  @spec new(destination :: type_destination(), asset :: type_asset(), amount :: type_amount()) :: t()
  def new(
    %MuxedAccount{} = destination,
    %Asset{} = asset,
    %Int64{} = amount
  ),
  do: %__MODULE__{destination: destination, asset: asset, amount: amount}

  @impl true
  def encode_xdr(%__MODULE__{destination: destination, asset: asset, amount: amount}) do
    [destination: destination, asset: asset, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{destination: destination, asset: asset, amount: amount}) do
    [destination: destination, asset: asset, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [destination: destination, asset: asset, amount: amount]}, rest}} ->
        {:ok, {new(destination, asset, amount), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [destination: destination, asset: asset, amount: amount]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(destination, asset, amount), rest}
  end
end
