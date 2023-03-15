defmodule StellarBase.XDR.SCObject do
  @moduledoc """
  Representation of Stellar `SCObjectStellarBase.XDR.SCObject` type.
  """
  alias StellarBase.XDR.{
    Int128Parts,
    Int64,
    SCAddress,
    SCContractCode,
    SCMap,
    SCObjectType,
    SCVec,
    UInt64,
    VariableOpaque256000
  }

  @behaviour XDR.Declaration

  @arms [
    SCO_VEC: SCVec,
    SCO_MAP: SCMap,
    SCO_U64: UInt64,
    SCO_I64: Int64,
    SCO_U128: Int128Parts,
    SCO_I128: Int128Parts,
    SCO_BYTES: VariableOpaque256000,
    SCO_CONTRACT_CODE: SCContractCode,
    SCO_ADDRESS: SCAddress,
    SCO_NONCE_KEY: SCAddress
  ]

  @type sc_object ::
          SCVec.t()
          | SCMap.t()
          | UInt64.t()
          | Int64.t()
          | Int128Parts.t()
          | VariableOpaque256000.t()
          | SCContractCode.t()
          | SCAddress.t()

  @type t :: %__MODULE__{sc_object: sc_object(), type: SCObjectType.t()}

  defstruct [:sc_object, :type]

  @spec new(sc_object :: sc_object(), type :: SCObjectType.t()) :: t()
  def new(sc_object, %SCObjectType{} = type),
    do: %__MODULE__{sc_object: sc_object, type: type}

  @impl true
  def encode_xdr(%__MODULE__{sc_object: sc_object, type: type}) do
    type
    |> XDR.Union.new(@arms, sc_object)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_object: sc_object, type: type}) do
    type
    |> XDR.Union.new(@arms, sc_object)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, sc_object}, rest}} -> {:ok, {new(sc_object, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, sc_object}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(sc_object, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCObjectType.new()
    |> XDR.Union.new(@arms)
  end
end
