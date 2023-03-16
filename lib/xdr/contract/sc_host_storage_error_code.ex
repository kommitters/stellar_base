defmodule StellarBase.XDR.SCHostStorageErrorCode do
  @moduledoc """
  Representation of Stellar `SCHostStorageErrorCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    HOST_STORAGE_UNKNOWN_ERROR: 0,
    HOST_STORAGE_EXPECT_CONTRACT_DATA: 1,
    HOST_STORAGE_READWRITE_ACCESS_TO_READONLY_ENTRY: 2,
    HOST_STORAGE_ACCESS_TO_UNKNOWN_ENTRY: 3,
    HOST_STORAGE_MISSING_KEY_IN_GET: 4,
    HOST_STORAGE_GET_ON_DELETED_KEY: 5
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :HOST_STORAGE_UNKNOWN_ERROR), do: %__MODULE__{identifier: type}

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
