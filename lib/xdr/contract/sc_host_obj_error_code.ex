defmodule StellarBase.XDR.SCHostObjErrorCode do
  @moduledoc """
  Representation of Stellar `SCHostObjErrorCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    HOST_OBJECT_UNKNOWN_ERROR: 0,
    HOST_OBJECT_UNKNOWN_REFERENCE: 1,
    HOST_OBJECT_UNEXPECTED_TYPE: 2,
    HOST_OBJECT_OBJECT_COUNT_EXCEEDS_U32_MAX: 3,
    HOST_OBJECT_OBJECT_NOT_EXIST: 4,
    HOST_OBJECT_VEC_INDEX_OUT_OF_BOUND: 5,
    HOST_OBJECT_CONTRACT_HASH_WRONG_LENGTH: 6
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :HOST_OBJECT_UNKNOWN_ERROR),
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
