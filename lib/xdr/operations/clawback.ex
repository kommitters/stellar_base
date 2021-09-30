defmodule Stellar.XDR.Operations.Clawback do
  @moduledoc """
  Representation of Stellar `Clawback` type.
  """
  alias Stellar.XDR.{Asset, Int64, MuxedAccount}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(asset: Asset, from: MuxedAccount, amount: Int64)

  @type t :: %__MODULE__{asset: Asset.t(), from: MuxedAccount.t(), amount: Int64.t()}

  defstruct [:asset, :from, :amount]

  @spec new(asset :: Asset.t(), from :: MuxedAccount.t(), amount :: Int64.t()) :: t()
  def new(%Asset{} = asset, %MuxedAccount{} = from, %Int64{} = amount),
    do: %__MODULE__{asset: asset, from: from, amount: amount}

  @impl true
  def encode_xdr(%__MODULE__{asset: asset, from: from, amount: amount}) do
    [asset: asset, from: from, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{asset: asset, from: from, amount: amount}) do
    [asset: asset, from: from, amount: amount]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [asset: asset, from: from, amount: amount]}, rest}} ->
        {:ok, {new(asset, from, amount), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [asset: asset, from: from, amount: amount]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(asset, from, amount), rest}
  end
end
