defmodule Stellar.XDR.FeeBumpTransaction do
  @moduledoc """
  Representation of Stellar `FeeBumpTransaction` type.
  """

  alias Stellar.XDR.{FeeBumpInnerTx, Int64, MuxedAccount, TransactionExt}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 fee_source: MuxedAccount,
                 fee: Int64,
                 inner_tx: FeeBumpInnerTx,
                 ext: TransactionExt
               )

  @type t :: %__MODULE__{
          fee_source: MuxedAccount.t(),
          fee: Int64.t(),
          inner_tx: FeeBumpInnerTx.t(),
          ext: TransactionExt.t()
        }

  defstruct [:fee_source, :fee, :inner_tx, :ext]

  @spec new(
          fee_source :: MuxedAccount.t(),
          fee :: Int64.t(),
          inner_tx :: FeeBumpInnerTx.t(),
          ext :: TransactionExt.t()
        ) :: t()
  def new(
        %MuxedAccount{} = fee_source,
        %Int64{} = fee,
        %FeeBumpInnerTx{} = inner_tx,
        %TransactionExt{} = ext
      ),
      do: %__MODULE__{fee_source: fee_source, fee: fee, inner_tx: inner_tx, ext: ext}

  @impl true
  def encode_xdr(%__MODULE__{fee_source: fee_source, fee: fee, inner_tx: inner_tx, ext: ext}) do
    [fee_source: fee_source, fee: fee, inner_tx: inner_tx, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{fee_source: fee_source, fee: fee, inner_tx: inner_tx, ext: ext}) do
    [fee_source: fee_source, fee: fee, inner_tx: inner_tx, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [fee_source: fee_source, fee: fee, inner_tx: inner_tx, ext: ext]},
        rest}} ->
        {:ok, {new(fee_source, fee, inner_tx, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [fee_source: fee_source, fee: fee, inner_tx: inner_tx, ext: ext]},
     rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(fee_source, fee, inner_tx, ext), rest}
  end
end
