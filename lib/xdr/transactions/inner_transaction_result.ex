defmodule StellarBase.XDR.InnerTransactionResult do
  @moduledoc """
  Representation of Stellar `InnerTransactionResult` type.
  InnerTransactionResult must be binary compatible with TransactionResult.
  """
  alias StellarBase.XDR.{Int64, TxResultV0}
  alias StellarBase.XDR.Ext

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(fee_charged: Int64, result: TxResultV0, ext: Ext)

  @type t :: %__MODULE__{fee_charged: Int64.t(), result: TxResultV0.t(), ext: Ext.t()}

  defstruct [:fee_charged, :result, :ext]

  @spec new(fee_charged :: Int64.t(), result :: TxResultV0.t(), ext :: Ext.t()) :: t()
  def new(%Int64{} = fee_charged, %TxResultV0{} = result, %Ext{} = ext),
    do: %__MODULE__{fee_charged: fee_charged, result: result, ext: ext}

  @impl true
  def encode_xdr(%__MODULE__{fee_charged: fee_charged, result: result, ext: ext}) do
    [fee_charged: fee_charged, result: result, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{fee_charged: fee_charged, result: result, ext: ext}) do
    [fee_charged: fee_charged, result: result, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [fee_charged: fee_charged, result: result, ext: ext]}, rest}} ->
        {:ok, {new(fee_charged, result, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [fee_charged: fee_charged, result: result, ext: ext]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(fee_charged, result, ext), rest}
  end
end
