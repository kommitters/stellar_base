defmodule StellarBase.XDR.SCVmErrorCode do
  @moduledoc """
  Representation of Stellar `SCVmErrorCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    VM_UNKNOWN: 0,
    VM_VALIDATION: 1,
    VM_INSTANTIATION: 2,
    VM_FUNCTION: 3,
    VM_TABLE: 4,
    VM_MEMORY: 5,
    VM_GLOBAL: 6,
    VM_VALUE: 7,
    VM_TRAP_UNREACHABLE: 8,
    VM_TRAP_MEMORY_ACCESS_OUT_OF_BOUNDS: 9,
    VM_TRAP_TABLE_ACCESS_OUT_OF_BOUNDS: 10,
    VM_TRAP_ELEM_UNINITIALIZED: 11,
    VM_TRAP_DIVISION_BY_ZERO: 12,
    VM_TRAP_INTEGER_OVERFLOW: 13,
    VM_TRAP_INVALID_CONVERSION_TO_INT: 14,
    VM_TRAP_STACK_OVERFLOW: 15,
    VM_TRAP_UNEXPECTED_SIGNATURE: 16,
    VM_TRAP_MEM_LIMIT_EXCEEDED: 17,
    VM_TRAP_CPU_LIMIT_EXCEEDED: 18
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :VM_UNKNOWN), do: %__MODULE__{identifier: type}

  @impl true
  def encode_xdr(%__MODULE__{identifier: type}) do
    @declarations
    |> XDR.Enum.new(type)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: type}) do
    @declarations
    |> XDR.Enum.new(type)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: type}, rest}} -> {:ok, {new(type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: type}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(type), rest}
  end
end
