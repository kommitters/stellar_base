defmodule StellarBase.XDR.SCSpecEntry do
  @moduledoc """
  Representation of Stellar `SCSpecEntry` kind.
  """

  alias StellarBase.XDR.{
    SCSpecEntryKind,
    SCSpecFunctionV0,
    SCSpecUDTStructV0,
    SCSpecUDTUnionV0,
    SCSpecUDTEnumV0,
    SCSpecUDTErrorEnumV0
  }

  @behaviour XDR.Declaration

  @arms [
    SC_SPEC_ENTRY_FUNCTION_V0: SCSpecFunctionV0,
    SC_SPEC_ENTRY_UDT_STRUCT_V0: SCSpecUDTStructV0,
    SC_SPEC_ENTRY_UDT_UNION_V0: SCSpecUDTUnionV0,
    SC_SPEC_ENTRY_UDT_ENUM_V0: SCSpecUDTEnumV0,
    SC_SPEC_ENTRY_UDT_ERROR_ENUM_V0: SCSpecUDTErrorEnumV0
  ]

  @type code ::
          SCSpecFunctionV0.t()
          | SCSpecUDTStructV0.t()
          | SCSpecUDTUnionV0.t()
          | SCSpecUDTEnumV0.t()
          | SCSpecUDTErrorEnumV0.t()

  @type kind :: SCSpecEntryKind.t()

  @type t :: %__MODULE__{code: code(), kind: kind()}

  defstruct [:code, :kind]

  @spec new(code :: code(), kind :: kind()) :: t()
  def new(code, %SCSpecEntryKind{} = kind), do: %__MODULE__{code: code, kind: kind}

  @impl true
  def encode_xdr(%__MODULE__{code: code, kind: kind}) do
    kind
    |> XDR.Union.new(@arms, code)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{code: code, kind: kind}) do
    kind
    |> XDR.Union.new(@arms, code)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{kind, code}, rest}} -> {:ok, {new(code, kind), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{kind, code}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(code, kind), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCSpecEntryKind.new()
    |> XDR.Union.new(@arms)
  end
end
