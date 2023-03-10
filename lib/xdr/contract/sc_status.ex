defmodule StellarBase.XDR.SCStatus do
  @moduledoc """
  Representation of Stellar `SCStatus` type.
  """
  alias StellarBase.XDR.{
    SCUnknownErrorCode,
    SCHostValErrorCode,
    SCHostObjErrorCode,
    SCHostFnErrorCode,
    SCHostStorageErrorCode,
    SCHostContextErrorCode,
    SCVmErrorCode,
    SCHostAuthErrorCode,
    SCStatusType,
    UInt32,
    Void
  }

  @behaviour XDR.Declaration

  @arms [
    SST_OK: Void,
    SST_UNKNOWN_ERROR: SCUnknownErrorCode,
    SST_HOST_VALUE_ERROR: SCHostValErrorCode,
    SST_HOST_OBJECT_ERROR: SCHostObjErrorCode,
    SST_HOST_FUNCTION_ERROR: SCHostFnErrorCode,
    SST_HOST_STORAGE_ERROR: SCHostStorageErrorCode,
    SST_HOST_CONTEXT_ERROR: SCHostContextErrorCode,
    SST_VM_ERROR: SCVmErrorCode,
    SST_CONTRACT_ERROR: UInt32,
    SST_HOST_AUTH_ERROR: SCHostAuthErrorCode
  ]

  @type code ::
          SCUnknownErrorCode.t()
          | SCHostValErrorCode.t()
          | SCHostObjErrorCode.t()
          | SCHostFnErrorCode.t()
          | SCHostStorageErrorCode.t()
          | SCHostContextErrorCode.t()
          | SCVmErrorCode.t()
          | SCHostAuthErrorCode.t()
          | SCStatusType.t()
          | UInt32.t()
          | Void

  @type t :: %__MODULE__{code: code(), type: SCStatusType.t()}

  defstruct [:code, :type]

  @spec new(code :: code(), type :: SCStatusType.t()) :: t()
  def new(code, %SCStatusType{} = type),
    do: %__MODULE__{code: code, type: type}

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
    |> SCStatusType.new()
    |> XDR.Union.new(@arms)
  end
end
