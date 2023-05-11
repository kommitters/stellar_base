defmodule StellarBase.XDR.SCSpecTypeDef do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SCSpecTypeDef` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    SCSpecType,
    Void,
    SCSpecTypeOption,
    SCSpecTypeResult,
    SCSpecTypeVec,
    SCSpecTypeMap,
    SCSpecTypeSet,
    SCSpecTypeTuple,
    SCSpecTypeBytesN,
    SCSpecTypeUDT
  }

  @arms [
    SC_SPEC_TYPE_VAL: Void,
    SC_SPEC_TYPE_BOOL: Void,
    SC_SPEC_TYPE_VOID: Void,
    SC_SPEC_TYPE_STATUS: Void,
    SC_SPEC_TYPE_U32: Void,
    SC_SPEC_TYPE_I32: Void,
    SC_SPEC_TYPE_U64: Void,
    SC_SPEC_TYPE_I64: Void,
    SC_SPEC_TYPE_TIMEPOINT: Void,
    SC_SPEC_TYPE_DURATION: Void,
    SC_SPEC_TYPE_U128: Void,
    SC_SPEC_TYPE_I128: Void,
    SC_SPEC_TYPE_U256: Void,
    SC_SPEC_TYPE_I256: Void,
    SC_SPEC_TYPE_BYTES: Void,
    SC_SPEC_TYPE_STRING: Void,
    SC_SPEC_TYPE_SYMBOL: Void,
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

  @type value ::
          Void.t()
          | SCSpecTypeOption.t()
          | SCSpecTypeResult.t()
          | SCSpecTypeVec.t()
          | SCSpecTypeMap.t()
          | SCSpecTypeSet.t()
          | SCSpecTypeTuple.t()
          | SCSpecTypeBytesN.t()
          | SCSpecTypeUDT.t()

  @type t :: %__MODULE__{value: value(), type: SCSpecType.t()}

  defstruct [:value, :type]

  @spec new(value :: value(), type :: SCSpecType.t()) :: t()
  def new(value, %SCSpecType{} = type), do: %__MODULE__{value: value, type: type}

  @impl true
  def encode_xdr(%__MODULE__{value: value, type: type}) do
    type
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value, type: type}) do
    type
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, value}, rest}} -> {:ok, {new(value, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, value}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(value, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCSpecType.new()
    |> XDR.Union.new(@arms)
  end
end
