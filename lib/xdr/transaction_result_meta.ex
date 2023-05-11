defmodule StellarBase.XDR.TransactionResultMeta do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `TransactionResultMeta` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    TransactionResultPair,
    LedgerEntryChanges,
    TransactionMeta
  }

  @struct_spec XDR.Struct.new(
    result: TransactionResultPair,
    fee_processing: LedgerEntryChanges,
    tx_apply_processing: TransactionMeta
  )

  @type type_result :: TransactionResultPair.t()
  @type type_fee_processing :: LedgerEntryChanges.t()
  @type type_tx_apply_processing :: TransactionMeta.t()

  @type t :: %__MODULE__{result: type_result(), fee_processing: type_fee_processing(), tx_apply_processing: type_tx_apply_processing()}

  defstruct [:result, :fee_processing, :tx_apply_processing]

  @spec new(result :: type_result(), fee_processing :: type_fee_processing(), tx_apply_processing :: type_tx_apply_processing()) :: t()
  def new(
    %TransactionResultPair{} = result,
    %LedgerEntryChanges{} = fee_processing,
    %TransactionMeta{} = tx_apply_processing
  ),
  do: %__MODULE__{result: result, fee_processing: fee_processing, tx_apply_processing: tx_apply_processing}

  @impl true
  def encode_xdr(%__MODULE__{result: result, fee_processing: fee_processing, tx_apply_processing: tx_apply_processing}) do
    [result: result, fee_processing: fee_processing, tx_apply_processing: tx_apply_processing]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{result: result, fee_processing: fee_processing, tx_apply_processing: tx_apply_processing}) do
    [result: result, fee_processing: fee_processing, tx_apply_processing: tx_apply_processing]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [result: result, fee_processing: fee_processing, tx_apply_processing: tx_apply_processing]}, rest}} ->
        {:ok, {new(result, fee_processing, tx_apply_processing), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [result: result, fee_processing: fee_processing, tx_apply_processing: tx_apply_processing]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(result, fee_processing, tx_apply_processing), rest}
  end
end
