defmodule StellarBase.XDR.PreconditionsV2 do
  @moduledoc """

  """
  alias StellarBase.XDR.{TimeBounds, LedgerBounds, SequenceNumber, UInt64, UInt32, ExtraSigners}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 time_bounds: TimeBounds,
                 ledger_bounds: LedgerBounds,
                 min_seq_num: SequenceNumber,
                 min_seq_age: UInt64,
                 min_seq_ledger_gap: UInt32,
                 extra_signers: ExtraSigners
               )

  @type t :: %__MODULE__{
          time_bounds: TimeBounds.t(),
          ledger_bounds: LedgerBounds.t(),
          min_seq_num: SequenceNumber.t(),
          min_seq_age: UInt64.t(),
          min_seq_ledger_gap: UInt32.t(),
          extra_signers: ExtraSigners.t()
        }

  defstruct [
    :time_bounds,
    :ledger_bounds,
    :min_seq_num,
    :min_seq_age,
    :min_seq_ledger_gap,
    :extra_signers
  ]

  @spec new(
          time_bounds :: TimeBounds.t(),
          ledger_bounds :: LedgerBounds.t(),
          min_seq_num :: SequenceNumber.t(),
          min_seq_age :: UInt64.t(),
          min_seq_ledger_gap :: UInt32.t(),
          extra_signers :: ExtraSigners.t()
        ) :: t()
  def new(
        %TimeBounds{} = time_bounds,
        %LedgerBounds{} = ledger_bounds,
        %SequenceNumber{} = min_seq_num,
        %UInt64{} = min_seq_age,
        %UInt32{} = min_seq_ledger_gap,
        %ExtraSigners{} = extra_signers
      ),
      do: %__MODULE__{
        time_bounds: time_bounds,
        ledger_bounds: ledger_bounds,
        min_seq_num: min_seq_num,
        min_seq_age: min_seq_age,
        min_seq_ledger_gap: min_seq_ledger_gap,
        extra_signers: extra_signers
      }

  @impl true
  def encode_xdr(%__MODULE__{
        time_bounds: time_bounds,
        ledger_bounds: ledger_bounds,
        min_seq_num: min_seq_num,
        min_seq_age: min_seq_age,
        min_seq_ledger_gap: min_seq_ledger_gap,
        extra_signers: extra_signers
      }) do
    [
      time_bounds: time_bounds,
      ledger_bounds: ledger_bounds,
      min_seq_num: min_seq_num,
      min_seq_age: min_seq_age,
      min_seq_ledger_gap: min_seq_ledger_gap,
      extra_signers: extra_signers
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        time_bounds: time_bounds,
        ledger_bounds: ledger_bounds,
        min_seq_num: min_seq_num,
        min_seq_age: min_seq_age,
        min_seq_ledger_gap: min_seq_ledger_gap,
        extra_signers: extra_signers
      }) do
    [
      time_bounds: time_bounds,
      ledger_bounds: ledger_bounds,
      min_seq_num: min_seq_num,
      min_seq_age: min_seq_age,
      min_seq_ledger_gap: min_seq_ledger_gap,
      extra_signers: extra_signers
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
            time_bounds: time_bounds,
            ledger_bounds: ledger_bounds,
            min_seq_num: min_seq_num,
            min_seq_age: min_seq_age,
            min_seq_ledger_gap: min_seq_ledger_gap,
            extra_signers: extra_signers
          ]
        }, rest}} ->
        {:ok,
         {new(
            time_bounds,
            ledger_bounds,
            min_seq_num,
            min_seq_age,
            min_seq_ledger_gap,
            extra_signers
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
         time_bounds: time_bounds,
         ledger_bounds: ledger_bounds,
         min_seq_num: min_seq_num,
         min_seq_age: min_seq_age,
         min_seq_ledger_gap: min_seq_ledger_gap,
         extra_signers: extra_signers
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       time_bounds,
       ledger_bounds,
       min_seq_num,
       min_seq_age,
       min_seq_ledger_gap,
       extra_signers
     ), rest}
  end
end
