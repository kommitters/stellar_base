defmodule StellarBase.XDR.SCStatusType do
  @moduledoc """
  Representation of Stellar `SCStatusType` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    SST_OK: 0,
    SST_UNKNOWN_ERROR: 1,
    SST_HOST_VALUE_ERROR: 2,
    SST_HOST_OBJECT_ERROR: 3,
    SST_HOST_FUNCTION_ERROR: 4,
    SST_HOST_STORAGE_ERROR: 5,
    SST_HOST_CONTEXT_ERROR: 6,
    SST_VM_ERROR: 7,
    SST_CONTRACT_ERROR: 8,
    SST_HOST_AUTH_ERROR: 9
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :SST_OK),
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
