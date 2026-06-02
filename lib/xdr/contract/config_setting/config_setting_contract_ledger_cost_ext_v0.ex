defmodule StellarBase.XDR.ConfigSettingContractLedgerCostExtV0 do
  @moduledoc """
  Representation of Stellar `ConfigSettingContractLedgerCostExtV0` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    UInt32,
    Int64
  }

  @struct_spec XDR.Struct.new(
                 tx_max_footprint_entries: UInt32,
                 fee_write1_kb: Int64
               )

  @type tx_max_footprint_entries_type :: UInt32.t()
  @type fee_write1_kb_type :: Int64.t()

  @type t :: %__MODULE__{
          tx_max_footprint_entries: tx_max_footprint_entries_type(),
          fee_write1_kb: fee_write1_kb_type()
        }

  defstruct [:tx_max_footprint_entries, :fee_write1_kb]

  @spec new(
          tx_max_footprint_entries :: tx_max_footprint_entries_type(),
          fee_write1_kb :: fee_write1_kb_type()
        ) :: t()
  def new(
        %UInt32{} = tx_max_footprint_entries,
        %Int64{} = fee_write1_kb
      ),
      do: %__MODULE__{
        tx_max_footprint_entries: tx_max_footprint_entries,
        fee_write1_kb: fee_write1_kb
      }

  @impl true
  def encode_xdr(%__MODULE__{
        tx_max_footprint_entries: tx_max_footprint_entries,
        fee_write1_kb: fee_write1_kb
      }) do
    [tx_max_footprint_entries: tx_max_footprint_entries, fee_write1_kb: fee_write1_kb]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        tx_max_footprint_entries: tx_max_footprint_entries,
        fee_write1_kb: fee_write1_kb
      }) do
    [tx_max_footprint_entries: tx_max_footprint_entries, fee_write1_kb: fee_write1_kb]
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
            tx_max_footprint_entries: tx_max_footprint_entries,
            fee_write1_kb: fee_write1_kb
          ]
        }, rest}} ->
        {:ok, {new(tx_max_footprint_entries, fee_write1_kb), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         tx_max_footprint_entries: tx_max_footprint_entries,
         fee_write1_kb: fee_write1_kb
       ]
     },
     rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(tx_max_footprint_entries, fee_write1_kb), rest}
  end
end
