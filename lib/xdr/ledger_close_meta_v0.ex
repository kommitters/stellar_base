defmodule StellarBase.XDR.LedgerCloseMetaV0 do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `LedgerCloseMetaV0` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    LedgerHeaderHistoryEntry,
    TransactionSet,
    TransactionResultMetaList,
    UpgradeEntryMetaList,
    SCPHistoryEntryList
  }

  @struct_spec XDR.Struct.new(
    ledger_header: LedgerHeaderHistoryEntry,
    tx_set: TransactionSet,
    tx_processing: TransactionResultMetaList,
    upgrades_processing: UpgradeEntryMetaList,
    scp_info: SCPHistoryEntryList
  )

  @type type_ledger_header :: LedgerHeaderHistoryEntry.t()
  @type type_tx_set :: TransactionSet.t()
  @type type_tx_processing :: TransactionResultMetaList.t()
  @type type_upgrades_processing :: UpgradeEntryMetaList.t()
  @type type_scp_info :: SCPHistoryEntryList.t()

  @type t :: %__MODULE__{ledger_header: type_ledger_header(), tx_set: type_tx_set(), tx_processing: type_tx_processing(), upgrades_processing: type_upgrades_processing(), scp_info: type_scp_info()}

  defstruct [:ledger_header, :tx_set, :tx_processing, :upgrades_processing, :scp_info]

  @spec new(ledger_header :: type_ledger_header(), tx_set :: type_tx_set(), tx_processing :: type_tx_processing(), upgrades_processing :: type_upgrades_processing(), scp_info :: type_scp_info()) :: t()
  def new(
    %LedgerHeaderHistoryEntry{} = ledger_header,
    %TransactionSet{} = tx_set,
    %TransactionResultMetaList{} = tx_processing,
    %UpgradeEntryMetaList{} = upgrades_processing,
    %SCPHistoryEntryList{} = scp_info
  ),
  do: %__MODULE__{ledger_header: ledger_header, tx_set: tx_set, tx_processing: tx_processing, upgrades_processing: upgrades_processing, scp_info: scp_info}

  @impl true
  def encode_xdr(%__MODULE__{ledger_header: ledger_header, tx_set: tx_set, tx_processing: tx_processing, upgrades_processing: upgrades_processing, scp_info: scp_info}) do
    [ledger_header: ledger_header, tx_set: tx_set, tx_processing: tx_processing, upgrades_processing: upgrades_processing, scp_info: scp_info]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ledger_header: ledger_header, tx_set: tx_set, tx_processing: tx_processing, upgrades_processing: upgrades_processing, scp_info: scp_info}) do
    [ledger_header: ledger_header, tx_set: tx_set, tx_processing: tx_processing, upgrades_processing: upgrades_processing, scp_info: scp_info]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [ledger_header: ledger_header, tx_set: tx_set, tx_processing: tx_processing, upgrades_processing: upgrades_processing, scp_info: scp_info]}, rest}} ->
        {:ok, {new(ledger_header, tx_set, tx_processing, upgrades_processing, scp_info), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [ledger_header: ledger_header, tx_set: tx_set, tx_processing: tx_processing, upgrades_processing: upgrades_processing, scp_info: scp_info]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(ledger_header, tx_set, tx_processing, upgrades_processing, scp_info), rest}
  end
end
