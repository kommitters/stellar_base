defmodule StellarBase.XDR.SCValType do
  @moduledoc """
  Representation of Stellar `SCValType` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    SCV_BOOL: 0,
    SCV_VOID: 1,
    SCV_STATUS: 2,
    SCV_U32: 3,
    SCV_I32: 4,
    SCV_U64: 5,
    SCV_I64: 6,
    SCV_TIMEPOINT: 7,
    SCV_DURATION: 8,
    SCV_U128: 9,
    SCV_I128: 10,
    SCV_U256: 11,
    SCV_I256: 12,
    SCV_BYTES: 13,
    SCV_STRING: 14,
    SCV_SYMBOL: 15,
    SCV_VEC: 16,
    SCV_MAP: 17,
    SCV_CONTRACT_EXECUTABLE: 18,
    SCV_ADDRESS: 19,
    SCV_LEDGER_KEY_CONTRACT_EXECUTABLE: 20,
    SCV_LEDGER_KEY_NONCE: 21
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :SCV_BOOL), do: %__MODULE__{identifier: type}

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
