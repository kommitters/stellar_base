defmodule Stellar.XDR.Transaction do
  @moduledoc """
  Representation of Stellar `Transaction` type.
  """
  alias Stellar.XDR.{
    UInt32,
    MuxedAccount,
    SequenceNumber,
    OptionalTimeBounds,
    Memo,
    # Operations,
    TransactionExt
  }

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 source_account: MuxedAccount,
                 fee: UInt32,
                 seq_num: SequenceNumber,
                 time_bounds: OptionalTimeBounds,
                 memo: Memo,
                 # operations: Operations,
                 ext: TransactionExt
               )

  defstruct [:source_account, :fee, :seq_num, :time_bounds, :memo, :operations, :ext]

  @impl true
  def encode_xdr(%__MODULE__{}) do
  end

  @impl true
  def encode_xdr!(%__MODULE__{}) do
  end

  @impl true
  def decode_xdr(_bytes, _spec \\ @struct_spec) do
  end

  @impl true
  def decode_xdr!(_bytes, _spec \\ @struct_spec) do
  end
end
