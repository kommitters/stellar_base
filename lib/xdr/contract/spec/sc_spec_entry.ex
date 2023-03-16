defmodule StellarBase.XDR.SCSpecEntry do
  @moduledoc """
  Representation of Stellar `SCSpecEntry` type.
  """

  alias StellarBase.XDR.{
    # SCSpecFunctionV0,
    SCSpecUDTStructV0,
    SCSpecUDTUnionV0,
    SCSpecUDTEnumV0,
    SCSpecUDTErrorEnumV0,
    SCSpecEntryKind
  }

  @behaviour XDR.Declaration

  @arms [
    # SC_SPEC_ENTRY_FUNCTION_V0: SCSpecFunctionV0,
    SC_SPEC_ENTRY_UDT_STRUCT_V0: SCSpecUDTUnionCaseTupleV0,
    SC_SPEC_ENTRY_UDT_UNION_V0: SCSpecUDTUnionV0,
    SC_SPEC_ENTRY_UDT_ENUM_V0: SCSpecUDTEnumV0,
    SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0: SCSpecUDTErrorEnumV0
  ]

  # SCSpecFunctionV0.t()
  @type entry ::
          SCSpecUDTStructV0.t()
          | SCSpecUDTUnionV0.t()
          | SCSpecUDTEnumV0.t()
          | SCSpecUDTErrorEnumV0.t()

  @type t :: %__MODULE__{
          entry: entry(),
          type: SCSpecEntryKind.t()
        }

  defstruct [:entry, :type]

  @spec new(entry :: entry(), type :: SCSpecEntryKind.t()) :: t()
  def new(entry, %SCSpecEntryKind{} = type), do: %__MODULE__{entry: entry, type: type}

  @impl true
  def encode_xdr(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{entry: entry, type: type}) do
    type
    |> XDR.Union.new(@arms, entry)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, entry}, rest}} -> {:ok, {new(entry, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, entry}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(entry, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCSpecEntryKind.new()
    |> XDR.Union.new(@arms)
  end
end
