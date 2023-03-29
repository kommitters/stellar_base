defmodule StellarBase.XDR.ThresholdIndexes do
  @moduledoc """
  Representation of Stellar `ThresholdIndexes` type.
  """

  @behaviour XDR.Declaration

  @declarations [
    THRESHOLD_MASTER_WEIGHT: 0,
    THRESHOLD_LOW: 1,
    THRESHOLD_MED: 2,
    THRESHOLD_HIGH: 3
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom() | nil) :: t()
  def new(type \\ nil), do: %__MODULE__{identifier: type}

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
