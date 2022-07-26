defmodule StellarBase.XDR.PreconditionsV2 do
  @moduledoc """
  Representation of Stellar `PreconditionsV2` type.

  PreconditionsV2 is a set of new optional preconditions for a transaction added in the CAP-21.
  """
  alias StellarBase.XDR.{
    OptionalTimeBounds,
    OptionalLedgerBounds,
    OptionalSequenceNumber,
    Duration,
    UInt32,
    SignerKeyList
  }

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 time_bounds: OptionalTimeBounds,
                 ledger_bounds: OptionalLedgerBounds,
                 min_seq_num: OptionalSequenceNumber,
                 min_seq_age: Duration,
                 min_seq_ledger_gap: UInt32,
                 extra_signers: SignerKeyList
               )

  @type t :: %__MODULE__{
          time_bounds: OptionalTimeBounds.t(),
          ledger_bounds: OptionalLedgerBounds.t(),
          min_seq_num: OptionalSequenceNumber.t(),
          min_seq_age: Duration.t(),
          min_seq_ledger_gap: UInt32.t(),
          extra_signers: SignerKeyList.t()
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
          time_bounds :: OptionalTimeBounds.t(),
          ledger_bounds :: OptionalLedgerBounds.t(),
          min_seq_num :: OptionalSequenceNumber.t(),
          min_seq_age :: Duration.t(),
          min_seq_ledger_gap :: UInt32.t(),
          extra_signers :: SignerKeyList.t()
        ) :: t()
  def new(
        %OptionalTimeBounds{} = time_bounds,
        %OptionalLedgerBounds{} = ledger_bounds,
        %OptionalSequenceNumber{} = min_seq_num,
        %Duration{} = min_seq_age,
        %UInt32{} = min_seq_ledger_gap,
        %SignerKeyList{} = extra_signers
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
