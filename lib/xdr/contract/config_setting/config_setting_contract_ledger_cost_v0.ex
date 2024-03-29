defmodule StellarBase.XDR.ConfigSettingContractLedgerCostV0 do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ConfigSettingContractLedgerCostV0` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    UInt32,
    Int64
  }

  @struct_spec XDR.Struct.new(
                 ledger_max_read_ledger_entries: UInt32,
                 ledger_max_read_bytes: UInt32,
                 ledger_max_write_ledger_entries: UInt32,
                 ledger_max_write_bytes: UInt32,
                 tx_max_read_ledger_entries: UInt32,
                 tx_max_read_bytes: UInt32,
                 tx_max_write_ledger_entries: UInt32,
                 tx_max_write_bytes: UInt32,
                 fee_read_ledger_entry: Int64,
                 fee_write_ledger_entry: Int64,
                 fee_read1_kb: Int64,
                 fee_write1_kb: Int64,
                 bucket_list_size_bytes: Int64,
                 bucket_list_fee_rate_low: Int64,
                 bucket_list_fee_rate_high: Int64,
                 bucket_list_growth_factor: UInt32
               )

  @type ledger_max_read_ledger_entries_type :: UInt32.t()
  @type ledger_max_read_bytes_type :: UInt32.t()
  @type ledger_max_write_ledger_entries_type :: UInt32.t()
  @type ledger_max_write_bytes_type :: UInt32.t()
  @type tx_max_read_ledger_entries_type :: UInt32.t()
  @type tx_max_read_bytes_type :: UInt32.t()
  @type tx_max_write_ledger_entries_type :: UInt32.t()
  @type tx_max_write_bytes_type :: UInt32.t()
  @type fee_read_ledger_entry_type :: Int64.t()
  @type fee_write_ledger_entry_type :: Int64.t()
  @type fee_read1_kb_type :: Int64.t()
  @type fee_write1_kb_type :: Int64.t()
  @type bucket_list_size_bytes_type :: Int64.t()
  @type bucket_list_fee_rate_low_type :: Int64.t()
  @type bucket_list_fee_rate_high_type :: Int64.t()
  @type bucket_list_growth_factor_type :: UInt32.t()

  @type t :: %__MODULE__{
          ledger_max_read_ledger_entries: ledger_max_read_ledger_entries_type(),
          ledger_max_read_bytes: ledger_max_read_bytes_type(),
          ledger_max_write_ledger_entries: ledger_max_write_ledger_entries_type(),
          ledger_max_write_bytes: ledger_max_write_bytes_type(),
          tx_max_read_ledger_entries: tx_max_read_ledger_entries_type(),
          tx_max_read_bytes: tx_max_read_bytes_type(),
          tx_max_write_ledger_entries: tx_max_write_ledger_entries_type(),
          tx_max_write_bytes: tx_max_write_bytes_type(),
          fee_read_ledger_entry: fee_read_ledger_entry_type(),
          fee_write_ledger_entry: fee_write_ledger_entry_type(),
          fee_read1_kb: fee_read1_kb_type(),
          fee_write1_kb: fee_write1_kb_type(),
          bucket_list_size_bytes: bucket_list_size_bytes_type(),
          bucket_list_fee_rate_low: bucket_list_fee_rate_low_type(),
          bucket_list_fee_rate_high: bucket_list_fee_rate_high_type(),
          bucket_list_growth_factor: bucket_list_growth_factor_type()
        }

  defstruct [
    :ledger_max_read_ledger_entries,
    :ledger_max_read_bytes,
    :ledger_max_write_ledger_entries,
    :ledger_max_write_bytes,
    :tx_max_read_ledger_entries,
    :tx_max_read_bytes,
    :tx_max_write_ledger_entries,
    :tx_max_write_bytes,
    :fee_read_ledger_entry,
    :fee_write_ledger_entry,
    :fee_read1_kb,
    :fee_write1_kb,
    :bucket_list_size_bytes,
    :bucket_list_fee_rate_low,
    :bucket_list_fee_rate_high,
    :bucket_list_growth_factor
  ]

  @spec new(
          ledger_max_read_ledger_entries :: ledger_max_read_ledger_entries_type(),
          ledger_max_read_bytes :: ledger_max_read_bytes_type(),
          ledger_max_write_ledger_entries :: ledger_max_write_ledger_entries_type(),
          ledger_max_write_bytes :: ledger_max_write_bytes_type(),
          tx_max_read_ledger_entries :: tx_max_read_ledger_entries_type(),
          tx_max_read_bytes :: tx_max_read_bytes_type(),
          tx_max_write_ledger_entries :: tx_max_write_ledger_entries_type(),
          tx_max_write_bytes :: tx_max_write_bytes_type(),
          fee_read_ledger_entry :: fee_read_ledger_entry_type(),
          fee_write_ledger_entry :: fee_write_ledger_entry_type(),
          fee_read1_kb :: fee_read1_kb_type(),
          fee_write1_kb :: fee_write1_kb_type(),
          bucket_list_size_bytes :: bucket_list_size_bytes_type(),
          bucket_list_fee_rate_low :: bucket_list_fee_rate_low_type(),
          bucket_list_fee_rate_high :: bucket_list_fee_rate_high_type(),
          bucket_list_growth_factor :: bucket_list_growth_factor_type()
        ) :: t()
  def new(
        %UInt32{} = ledger_max_read_ledger_entries,
        %UInt32{} = ledger_max_read_bytes,
        %UInt32{} = ledger_max_write_ledger_entries,
        %UInt32{} = ledger_max_write_bytes,
        %UInt32{} = tx_max_read_ledger_entries,
        %UInt32{} = tx_max_read_bytes,
        %UInt32{} = tx_max_write_ledger_entries,
        %UInt32{} = tx_max_write_bytes,
        %Int64{} = fee_read_ledger_entry,
        %Int64{} = fee_write_ledger_entry,
        %Int64{} = fee_read1_kb,
        %Int64{} = fee_write1_kb,
        %Int64{} = bucket_list_size_bytes,
        %Int64{} = bucket_list_fee_rate_low,
        %Int64{} = bucket_list_fee_rate_high,
        %UInt32{} = bucket_list_growth_factor
      ),
      do: %__MODULE__{
        ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
        ledger_max_read_bytes: ledger_max_read_bytes,
        ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
        ledger_max_write_bytes: ledger_max_write_bytes,
        tx_max_read_ledger_entries: tx_max_read_ledger_entries,
        tx_max_read_bytes: tx_max_read_bytes,
        tx_max_write_ledger_entries: tx_max_write_ledger_entries,
        tx_max_write_bytes: tx_max_write_bytes,
        fee_read_ledger_entry: fee_read_ledger_entry,
        fee_write_ledger_entry: fee_write_ledger_entry,
        fee_read1_kb: fee_read1_kb,
        fee_write1_kb: fee_write1_kb,
        bucket_list_size_bytes: bucket_list_size_bytes,
        bucket_list_fee_rate_low: bucket_list_fee_rate_low,
        bucket_list_fee_rate_high: bucket_list_fee_rate_high,
        bucket_list_growth_factor: bucket_list_growth_factor
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
        ledger_max_read_bytes: ledger_max_read_bytes,
        ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
        ledger_max_write_bytes: ledger_max_write_bytes,
        tx_max_read_ledger_entries: tx_max_read_ledger_entries,
        tx_max_read_bytes: tx_max_read_bytes,
        tx_max_write_ledger_entries: tx_max_write_ledger_entries,
        tx_max_write_bytes: tx_max_write_bytes,
        fee_read_ledger_entry: fee_read_ledger_entry,
        fee_write_ledger_entry: fee_write_ledger_entry,
        fee_read1_kb: fee_read1_kb,
        fee_write1_kb: fee_write1_kb,
        bucket_list_size_bytes: bucket_list_size_bytes,
        bucket_list_fee_rate_low: bucket_list_fee_rate_low,
        bucket_list_fee_rate_high: bucket_list_fee_rate_high,
        bucket_list_growth_factor: bucket_list_growth_factor
      }) do
    [
      ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
      ledger_max_read_bytes: ledger_max_read_bytes,
      ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
      ledger_max_write_bytes: ledger_max_write_bytes,
      tx_max_read_ledger_entries: tx_max_read_ledger_entries,
      tx_max_read_bytes: tx_max_read_bytes,
      tx_max_write_ledger_entries: tx_max_write_ledger_entries,
      tx_max_write_bytes: tx_max_write_bytes,
      fee_read_ledger_entry: fee_read_ledger_entry,
      fee_write_ledger_entry: fee_write_ledger_entry,
      fee_read1_kb: fee_read1_kb,
      fee_write1_kb: fee_write1_kb,
      bucket_list_size_bytes: bucket_list_size_bytes,
      bucket_list_fee_rate_low: bucket_list_fee_rate_low,
      bucket_list_fee_rate_high: bucket_list_fee_rate_high,
      bucket_list_growth_factor: bucket_list_growth_factor
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
        ledger_max_read_bytes: ledger_max_read_bytes,
        ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
        ledger_max_write_bytes: ledger_max_write_bytes,
        tx_max_read_ledger_entries: tx_max_read_ledger_entries,
        tx_max_read_bytes: tx_max_read_bytes,
        tx_max_write_ledger_entries: tx_max_write_ledger_entries,
        tx_max_write_bytes: tx_max_write_bytes,
        fee_read_ledger_entry: fee_read_ledger_entry,
        fee_write_ledger_entry: fee_write_ledger_entry,
        fee_read1_kb: fee_read1_kb,
        fee_write1_kb: fee_write1_kb,
        bucket_list_size_bytes: bucket_list_size_bytes,
        bucket_list_fee_rate_low: bucket_list_fee_rate_low,
        bucket_list_fee_rate_high: bucket_list_fee_rate_high,
        bucket_list_growth_factor: bucket_list_growth_factor
      }) do
    [
      ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
      ledger_max_read_bytes: ledger_max_read_bytes,
      ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
      ledger_max_write_bytes: ledger_max_write_bytes,
      tx_max_read_ledger_entries: tx_max_read_ledger_entries,
      tx_max_read_bytes: tx_max_read_bytes,
      tx_max_write_ledger_entries: tx_max_write_ledger_entries,
      tx_max_write_bytes: tx_max_write_bytes,
      fee_read_ledger_entry: fee_read_ledger_entry,
      fee_write_ledger_entry: fee_write_ledger_entry,
      fee_read1_kb: fee_read1_kb,
      fee_write1_kb: fee_write1_kb,
      bucket_list_size_bytes: bucket_list_size_bytes,
      bucket_list_fee_rate_low: bucket_list_fee_rate_low,
      bucket_list_fee_rate_high: bucket_list_fee_rate_high,
      bucket_list_growth_factor: bucket_list_growth_factor
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
            ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
            ledger_max_read_bytes: ledger_max_read_bytes,
            ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
            ledger_max_write_bytes: ledger_max_write_bytes,
            tx_max_read_ledger_entries: tx_max_read_ledger_entries,
            tx_max_read_bytes: tx_max_read_bytes,
            tx_max_write_ledger_entries: tx_max_write_ledger_entries,
            tx_max_write_bytes: tx_max_write_bytes,
            fee_read_ledger_entry: fee_read_ledger_entry,
            fee_write_ledger_entry: fee_write_ledger_entry,
            fee_read1_kb: fee_read1_kb,
            fee_write1_kb: fee_write1_kb,
            bucket_list_size_bytes: bucket_list_size_bytes,
            bucket_list_fee_rate_low: bucket_list_fee_rate_low,
            bucket_list_fee_rate_high: bucket_list_fee_rate_high,
            bucket_list_growth_factor: bucket_list_growth_factor
          ]
        }, rest}} ->
        {:ok,
         {new(
            ledger_max_read_ledger_entries,
            ledger_max_read_bytes,
            ledger_max_write_ledger_entries,
            ledger_max_write_bytes,
            tx_max_read_ledger_entries,
            tx_max_read_bytes,
            tx_max_write_ledger_entries,
            tx_max_write_bytes,
            fee_read_ledger_entry,
            fee_write_ledger_entry,
            fee_read1_kb,
            fee_write1_kb,
            bucket_list_size_bytes,
            bucket_list_fee_rate_low,
            bucket_list_fee_rate_high,
            bucket_list_growth_factor
          ), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         ledger_max_read_ledger_entries: ledger_max_read_ledger_entries,
         ledger_max_read_bytes: ledger_max_read_bytes,
         ledger_max_write_ledger_entries: ledger_max_write_ledger_entries,
         ledger_max_write_bytes: ledger_max_write_bytes,
         tx_max_read_ledger_entries: tx_max_read_ledger_entries,
         tx_max_read_bytes: tx_max_read_bytes,
         tx_max_write_ledger_entries: tx_max_write_ledger_entries,
         tx_max_write_bytes: tx_max_write_bytes,
         fee_read_ledger_entry: fee_read_ledger_entry,
         fee_write_ledger_entry: fee_write_ledger_entry,
         fee_read1_kb: fee_read1_kb,
         fee_write1_kb: fee_write1_kb,
         bucket_list_size_bytes: bucket_list_size_bytes,
         bucket_list_fee_rate_low: bucket_list_fee_rate_low,
         bucket_list_fee_rate_high: bucket_list_fee_rate_high,
         bucket_list_growth_factor: bucket_list_growth_factor
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       ledger_max_read_ledger_entries,
       ledger_max_read_bytes,
       ledger_max_write_ledger_entries,
       ledger_max_write_bytes,
       tx_max_read_ledger_entries,
       tx_max_read_bytes,
       tx_max_write_ledger_entries,
       tx_max_write_bytes,
       fee_read_ledger_entry,
       fee_write_ledger_entry,
       fee_read1_kb,
       fee_write1_kb,
       bucket_list_size_bytes,
       bucket_list_fee_rate_low,
       bucket_list_fee_rate_high,
       bucket_list_growth_factor
     ), rest}
  end
end
