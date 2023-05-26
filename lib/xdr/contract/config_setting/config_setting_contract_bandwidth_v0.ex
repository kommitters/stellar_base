defmodule StellarBase.XDR.ConfigSettingContractBandwidthV0 do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ConfigSettingContractBandwidthV0` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    UInt32,
    Int64
  }

  @struct_spec XDR.Struct.new(
                 ledger_max_propagate_size_bytes: UInt32,
                 tx_max_size_bytes: UInt32,
                 fee_propagate_data1_kb: Int64
               )

  @type ledger_max_propagate_size_bytes_type :: UInt32.t()
  @type tx_max_size_bytes_type :: UInt32.t()
  @type fee_propagate_data1_kb_type :: Int64.t()

  @type t :: %__MODULE__{
          ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes_type(),
          tx_max_size_bytes: tx_max_size_bytes_type(),
          fee_propagate_data1_kb: fee_propagate_data1_kb_type()
        }

  defstruct [:ledger_max_propagate_size_bytes, :tx_max_size_bytes, :fee_propagate_data1_kb]

  @spec new(
          ledger_max_propagate_size_bytes :: ledger_max_propagate_size_bytes_type(),
          tx_max_size_bytes :: tx_max_size_bytes_type(),
          fee_propagate_data1_kb :: fee_propagate_data1_kb_type()
        ) :: t()
  def new(
        %UInt32{} = ledger_max_propagate_size_bytes,
        %UInt32{} = tx_max_size_bytes,
        %Int64{} = fee_propagate_data1_kb
      ),
      do: %__MODULE__{
        ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes,
        tx_max_size_bytes: tx_max_size_bytes,
        fee_propagate_data1_kb: fee_propagate_data1_kb
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes,
        tx_max_size_bytes: tx_max_size_bytes,
        fee_propagate_data1_kb: fee_propagate_data1_kb
      }) do
    [
      ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes,
      tx_max_size_bytes: tx_max_size_bytes,
      fee_propagate_data1_kb: fee_propagate_data1_kb
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes,
        tx_max_size_bytes: tx_max_size_bytes,
        fee_propagate_data1_kb: fee_propagate_data1_kb
      }) do
    [
      ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes,
      tx_max_size_bytes: tx_max_size_bytes,
      fee_propagate_data1_kb: fee_propagate_data1_kb
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
            ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes,
            tx_max_size_bytes: tx_max_size_bytes,
            fee_propagate_data1_kb: fee_propagate_data1_kb
          ]
        }, rest}} ->
        {:ok,
         {new(ledger_max_propagate_size_bytes, tx_max_size_bytes, fee_propagate_data1_kb), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         ledger_max_propagate_size_bytes: ledger_max_propagate_size_bytes,
         tx_max_size_bytes: tx_max_size_bytes,
         fee_propagate_data1_kb: fee_propagate_data1_kb
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(ledger_max_propagate_size_bytes, tx_max_size_bytes, fee_propagate_data1_kb), rest}
  end
end
