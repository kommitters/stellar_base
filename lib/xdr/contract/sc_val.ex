defmodule StellarBase.XDR.SCVal do
  @moduledoc """
  Representation of Stellar `SCVal` type.
  """

  alias StellarBase.XDR.{
    Int64,
    Int32,
    OptionalSCObject,
    UInt32,
    UInt64,
    SCValType,
    SCStatic,
    SCStatus,
    SCSymbol
  }

  @behaviour XDR.Declaration

  @arms [
    SCV_U63: Int64,
    SCV_U32: UInt32,
    SCV_I32: Int32,
    SCV_STATIC: SCStatic,
    SCV_OBJECT: OptionalSCObject,
    SCV_SYMBOL: SCSymbol,
    SCV_BITSET: UInt64,
    SCV_STATUS: SCStatus
  ]

  @type code ::
          Int64.t()
          | UInt32.t()
          | Int32.t()
          | SCStatic.t()
          | OptionalSCObject.t()
          | SCSymbol.t()
          | UInt64.t()
          | SCStatus.t()

  @type t :: %__MODULE__{code: code(), type: SCValType.t()}

  defstruct [:code, :type]

  @spec new(code :: code(), type :: SCValType.t()) :: t()
  def new(code, %SCValType{} = type), do: %__MODULE__{code: code, type: type}

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
    |> SCValType.new()
    |> XDR.Union.new(@arms)
  end
end
