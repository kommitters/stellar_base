defmodule StellarBase.XDR.SCSpecTypeDef do
  @moduledoc """
  Representation of Stellar `SCSpecTypeDef` type.
  """

  alias StellarBase.XDR.{
    SCSpecType,
    SCSpecTypeVec,
    SCSpecTypeMap,
    SCSpecTypeSet,
    SCSpecTypeTuple,
    SCSpecTypeBytesN,
    SCSpecTypeUDT,
    SCSpecTypeOption,
    SCSpecTypeResult,
    Void
  }

  @behaviour XDR.Declaration

  @arms [
    SC_SPEC_TYPE_VAL: Void,
    SC_SPEC_TYPE_U64: Void,
    SC_SPEC_TYPE_I64: Void,
    SC_SPEC_TYPE_U128: Void,
    SC_SPEC_TYPE_I128: Void,
    SC_SPEC_TYPE_U32: Void,
    SC_SPEC_TYPE_I32: Void,
    SC_SPEC_TYPE_BOOL: Void,
    SC_SPEC_TYPE_SYMBOL: Void,
    SC_SPEC_TYPE_BITSET: Void,
    SC_SPEC_TYPE_STATUS: Void,
    SC_SPEC_TYPE_BYTES: Void,
    SC_SPEC_TYPE_ADDRESS: Void,
    SC_SPEC_TYPE_OPTION: SCSpecTypeOption,
    SC_SPEC_TYPE_RESULT: SCSpecTypeResult,
    SC_SPEC_TYPE_VEC: SCSpecTypeVec,
    SC_SPEC_TYPE_MAP: SCSpecTypeMap,
    SC_SPEC_TYPE_SET: SCSpecTypeSet,
    SC_SPEC_TYPE_TUPLE: SCSpecTypeTuple,
    SC_SPEC_TYPE_BYTES_N: SCSpecTypeBytesN,
    SC_SPEC_TYPE_UDT: SCSpecTypeUDT
  ]

  @type code ::
          SCSpecTypeVec
          | SCSpecTypeMap
          | SCSpecTypeSet
          | SCSpecTypeTuple
          | SCSpecTypeBytesN
          | SCSpecTypeUDT
          | SCSpecTypeOption
          | SCSpecTypeResult
          | Void

  @type t :: %__MODULE__{code: code(), type: SCSpecType.t()}

  defstruct [:code, :type]

  @spec new(code :: code(), type :: SCSpecType.t()) :: t()
  def new(code, %SCSpecType{} = type), do: %__MODULE__{code: code, type: type}

  @impl true
  def encode_xdr(%__MODULE__{code: code, type: type}) do
    type
    |> XDR.Union.new(@arms, code)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{code: code, type: type}) do
    type
    |> XDR.Union.new(@arms, code)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, code}, rest}} -> {:ok, {new(code, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, code}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(code, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCSpecType.new()
    |> XDR.Union.new(@arms)
  end
end
