defmodule StellarBase.XDR.SCVal do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SCVal` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    SCValType,
    Bool,
    Void,
    SCError,
    UInt32,
    Int32,
    UInt64,
    Int64,
    TimePoint,
    Duration,
    UInt128Parts,
    Int128Parts,
    UInt256Parts,
    Int256Parts,
    SCBytes,
    SCString,
    SCSymbol,
    OptionalSCVec,
    OptionalSCMap,
    SCAddress,
    SCNonceKey,
    SCContractInstance
  }

  @arms [
    SCV_BOOL: Bool,
    SCV_VOID: Void,
    SCV_ERROR: SCError,
    SCV_U32: UInt32,
    SCV_I32: Int32,
    SCV_U64: UInt64,
    SCV_I64: Int64,
    SCV_TIMEPOINT: TimePoint,
    SCV_DURATION: Duration,
    SCV_U128: UInt128Parts,
    SCV_I128: Int128Parts,
    SCV_U256: UInt256Parts,
    SCV_I256: Int256Parts,
    SCV_BYTES: SCBytes,
    SCV_STRING: SCString,
    SCV_SYMBOL: SCSymbol,
    SCV_VEC: OptionalSCVec,
    SCV_MAP: OptionalSCMap,
    SCV_ADDRESS: SCAddress,
    SCV_LEDGER_KEY_CONTRACT_INSTANCE: Void,
    SCV_LEDGER_KEY_NONCE: SCNonceKey,
    SCV_CONTRACT_INSTANCE: SCContractInstance
  ]

  @type value ::
          Bool.t()
          | Void.t()
          | SCError.t()
          | UInt32.t()
          | Int32.t()
          | UInt64.t()
          | Int64.t()
          | TimePoint.t()
          | Duration.t()
          | Int128Parts.t()
          | UInt128Parts.t()
          | Int256Parts.t()
          | UInt256Parts.t()
          | SCBytes.t()
          | SCString.t()
          | SCSymbol.t()
          | OptionalSCVec.t()
          | OptionalSCMap.t()
          | SCAddress.t()
          | SCNonceKey.t()
          | SCContractInstance.t()

  @type t :: %__MODULE__{value: value(), type: SCValType.t()}

  defstruct [:value, :type]

  @spec new(value :: value(), type :: SCValType.t()) :: t()
  def new(value, %SCValType{} = type), do: %__MODULE__{value: value, type: type}

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
    |> SCValType.new()
    |> XDR.Union.new(@arms)
  end
end
