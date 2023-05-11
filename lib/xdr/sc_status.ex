defmodule StellarBase.XDR.SCStatus do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SCStatus` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    SCStatusType,
    Void,
    SCUnknownErrorCode,
    SCHostValErrorCode,
    SCHostObjErrorCode,
    SCHostFnErrorCode,
    SCHostStorageErrorCode,
    SCHostContextErrorCode,
    SCVmErrorCode,
    Uint32,
    SCHostAuthErrorCode
  }

  @arms [
    SST_OK: Void,
    SST_UNKNOWN_ERROR: SCUnknownErrorCode,
    SST_HOST_VALUE_ERROR: SCHostValErrorCode,
    SST_HOST_OBJECT_ERROR: SCHostObjErrorCode,
    SST_HOST_FUNCTION_ERROR: SCHostFnErrorCode,
    SST_HOST_STORAGE_ERROR: SCHostStorageErrorCode,
    SST_HOST_CONTEXT_ERROR: SCHostContextErrorCode,
    SST_VM_ERROR: SCVmErrorCode,
    SST_CONTRACT_ERROR: Uint32,
    SST_HOST_AUTH_ERROR: SCHostAuthErrorCode
  ]

  @type value ::
          Void.t()
          | SCUnknownErrorCode.t()
          | SCHostValErrorCode.t()
          | SCHostObjErrorCode.t()
          | SCHostFnErrorCode.t()
          | SCHostStorageErrorCode.t()
          | SCHostContextErrorCode.t()
          | SCVmErrorCode.t()
          | Uint32.t()
          | SCHostAuthErrorCode.t()

  @type t :: %__MODULE__{value: value(), type: SCStatusType.t()}

  defstruct [:value, :type]

  @spec new(value :: value(), type :: SCStatusType.t()) :: t()
  def new(value, %SCStatusType{} = type), do: %__MODULE__{value: value, type: type}

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
    |> SCStatusType.new()
    |> XDR.Union.new(@arms)
  end
end
