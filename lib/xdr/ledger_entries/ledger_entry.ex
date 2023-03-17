defmodule StellarBase.XDR.LedgerEntry do
  @moduledoc """
  Representation of Stellar `LedgerEntry` type.
  """

  alias StellarBase.XDR.{UInt32, LedgerEntryData, LedgerEntryExt}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 last_modified_ledger_seq: UInt32,
                 data: LedgerEntryData,
                 ledger_entry_ext: LedgerEntryExt
               )

  @type t :: %__MODULE__{
          last_modified_ledger_seq: UInt32.t(),
          data: LedgerEntryData.t(),
          ledger_entry_ext: LedgerEntryExt.t()
        }

  defstruct [:last_modified_ledger_seq, :data, :ledger_entry_ext]

  @spec new(
          last_modified_ledger_seq :: UInt32.t(),
          data :: LedgerEntryData.t(),
          ledger_entry_ext :: LedgerEntryExt.t()
        ) :: t()
  def new(
        %UInt32{} = last_modified_ledger_seq,
        %LedgerEntryData{} = data,
        %LedgerEntryExt{} = ledger_entry_ext
      ),
      do: %__MODULE__{
        last_modified_ledger_seq: last_modified_ledger_seq,
        data: data,
        ledger_entry_ext: ledger_entry_ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        last_modified_ledger_seq: last_modified_ledger_seq,
        data: data,
        ledger_entry_ext: ledger_entry_ext
      }) do
    [
      last_modified_ledger_seq: last_modified_ledger_seq,
      data: data,
      ledger_entry_ext: ledger_entry_ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        last_modified_ledger_seq: last_modified_ledger_seq,
        data: data,
        ledger_entry_ext: ledger_entry_ext
      }) do
    [
      last_modified_ledger_seq: last_modified_ledger_seq,
      data: data,
      ledger_entry_ext: ledger_entry_ext
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
            last_modified_ledger_seq: last_modified_ledger_seq,
            data: data,
            ledger_entry_ext: ledger_entry_ext
          ]
        }, rest}} ->
        {:ok, {new(last_modified_ledger_seq, data, ledger_entry_ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         last_modified_ledger_seq: last_modified_ledger_seq,
         data: data,
         ledger_entry_ext: ledger_entry_ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(last_modified_ledger_seq, data, ledger_entry_ext), rest}
  end
end
