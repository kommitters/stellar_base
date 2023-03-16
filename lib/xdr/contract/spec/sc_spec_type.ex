defmodule StellarBase.XDR.SCSpecType do
  @moduledoc """
  Representation of Stellar `SCSpecType` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    SC_SPEC_TYPE_VAL: 0,

    # Types with no parameters.
    SC_SPEC_TYPE_U32: 1,
    SC_SPEC_TYPE_I32: 2,
    SC_SPEC_TYPE_U64: 3,
    SC_SPEC_TYPE_I64: 4,
    SC_SPEC_TYPE_U128: 5,
    SC_SPEC_TYPE_I128: 6,
    SC_SPEC_TYPE_BOOL: 7,
    SC_SPEC_TYPE_SYMBOL: 8,
    SC_SPEC_TYPE_BITSET: 9,
    SC_SPEC_TYPE_STATUS: 10,
    SC_SPEC_TYPE_BYTES: 11,
    SC_SPEC_TYPE_INVOKER: 12,
    SC_SPEC_TYPE_ADDRESS: 13,

    # Types with parameters.
    SC_SPEC_TYPE_OPTION: 1000,
    SC_SPEC_TYPE_RESULT: 1001,
    SC_SPEC_TYPE_VEC: 1002,
    SC_SPEC_TYPE_SET: 1003,
    SC_SPEC_TYPE_MAP: 1004,
    SC_SPEC_TYPE_TUPLE: 1005,
    SC_SPEC_TYPE_BYTES_N: 1006,

    # User defined types.
    SC_SPEC_TYPE_UDT: 2000
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(code :: atom()) :: t()
  def new(code), do: %__MODULE__{identifier: code}

  @impl true
  def encode_xdr(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: code}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(code), rest}
  end
end
