defmodule StellarBase.XDR.SCHostValErrorCode do
  @moduledoc """
  Representation of Stellar `SCHostValErrorCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    HOST_VALUE_UNKNOWN_ERROR: 0,
    HOST_VALUE_RESERVED_TAG_VALUE: 1,
    HOST_VALUE_UNEXPECTED_VAL_TYPE: 2,
    HOST_VALUE_U63_OUT_OF_RANGE: 3,
    HOST_VALUE_U32_OUT_OF_RANGE: 4,
    HOST_VALUE_STATIC_UNKNOWN: 5,
    HOST_VALUE_MISSING_OBJECT: 6,
    HOST_VALUE_SYMBOL_TOO_LONG: 7,
    HOST_VALUE_SYMBOL_BAD_CHAR: 8,
    HOST_VALUE_SYMBOL_CONTAINS_NON_UTF8: 9,
    HOST_VALUE_BITSET_TOO_MANY_BITS: 10,
    HOST_VALUE_STATUS_UNKNOWN: 11
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :HOST_VALUE_UNKNOWN_ERROR),
    do: %__MODULE__{identifier: type}

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
