defmodule StellarBase.XDR.SorobanTransactionMeta do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SorobanTransactionMeta` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    SorobanTransactionMetaExt,
    ContractEventList,
    SCVal,
    DiagnosticEventList
  }

  @struct_spec XDR.Struct.new(
                 ext: SorobanTransactionMetaExt,
                 events: ContractEventList,
                 return_value: SCVal,
                 diagnostic_events: DiagnosticEventList
               )

  @type ext_type :: SorobanTransactionMetaExt.t()
  @type events_type :: ContractEventList.t()
  @type return_value_type :: SCVal.t()
  @type diagnostic_events_type :: DiagnosticEventList.t()

  @type t :: %__MODULE__{
          ext: ext_type(),
          events: events_type(),
          return_value: return_value_type(),
          diagnostic_events: diagnostic_events_type()
        }

  defstruct [:ext, :events, :return_value, :diagnostic_events]

  @spec new(
          ext :: ext_type(),
          events :: events_type(),
          return_value :: return_value_type(),
          diagnostic_events :: diagnostic_events_type()
        ) :: t()
  def new(
        %SorobanTransactionMetaExt{} = ext,
        %ContractEventList{} = events,
        %SCVal{} = return_value,
        %DiagnosticEventList{} = diagnostic_events
      ),
      do: %__MODULE__{
        ext: ext,
        events: events,
        return_value: return_value,
        diagnostic_events: diagnostic_events
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ext: ext,
        events: events,
        return_value: return_value,
        diagnostic_events: diagnostic_events
      }) do
    [ext: ext, events: events, return_value: return_value, diagnostic_events: diagnostic_events]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ext: ext,
        events: events,
        return_value: return_value,
        diagnostic_events: diagnostic_events
      }) do
    [ext: ext, events: events, return_value: return_value, diagnostic_events: diagnostic_events]
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
            ext: ext,
            events: events,
            return_value: return_value,
            diagnostic_events: diagnostic_events
          ]
        }, rest}} ->
        {:ok, {new(ext, events, return_value, diagnostic_events), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         ext: ext,
         events: events,
         return_value: return_value,
         diagnostic_events: diagnostic_events
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(ext, events, return_value, diagnostic_events), rest}
  end
end
