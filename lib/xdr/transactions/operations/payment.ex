defmodule StellarBase.XDR.Payment do
  @moduledoc """
  Representation of Stellar `Payment` type.
  """
  alias StellarBase.XDR.{Asset, Int64, MuxedAccount}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(destination: MuxedAccount, asset: Asset, amount: Int64)

  @type t :: %__MODULE__{destination: MuxedAccount.t(), asset: Asset.t(), amount: Int64.t()}

  defstruct [:destination, :asset, :amount]

  @spec new(destination :: MuxedAccount.t(), asset :: Asset.t(), amount :: Int64.t()) :: t()
  def new(%MuxedAccount{} = destination, %Asset{} = asset, %Int64{} = amount),
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
      {:ok,
       {%XDR.Struct{components: [destination: destination, asset: asset, amount: amount]}, rest}} ->
        {:ok, {new(destination, asset, amount), rest}}

      error ->
        error
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
