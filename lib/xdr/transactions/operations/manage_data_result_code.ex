defmodule StellarBase.XDR.Operations.ManageDataResultCode do
  @moduledoc """
  Representation of Stellar `ManageDataResultCode` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    # success
    MANAGE_DATA_SUCCESS: 0,
    # The network hasn't moved to this protocol change yet
    MANAGE_DATA_NOT_SUPPORTED_YET: -1,
    # Trying to remove a Data Entry that isn't there
    MANAGE_DATA_NAME_NOT_FOUND: -2,
    # not enough funds to create a new Data Entry
    MANAGE_DATA_LOW_RESERVE: -3,
    # Name not a valid string
    MANAGE_DATA_INVALID_NAME: -4
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
