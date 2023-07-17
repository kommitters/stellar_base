defmodule StellarBase.XDR.ManageData do
  @moduledoc """
  Representation of Stellar `ManageData` type.
  """
  alias StellarBase.XDR.{OptionalDataValue, String64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(data_name: String64, data_value: OptionalDataValue)

  @type t :: %__MODULE__{data_name: String64.t(), data_value: OptionalDataValue.t()}

  defstruct [:data_name, :data_value]

  @spec new(data_name :: String64.t(), data_value :: OptionalDataValue.t()) :: t()
  def new(%String64{} = data_name, %OptionalDataValue{} = data_value),
    do: %__MODULE__{data_name: data_name, data_value: data_value}

  @impl true
  def encode_xdr(%__MODULE__{data_name: data_name, data_value: data_value}) do
    [data_name: data_name, data_value: data_value]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{data_name: data_name, data_value: data_value}) do
    [data_name: data_name, data_value: data_value]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [data_name: data_name, data_value: data_value]}, rest}} ->
        {:ok, {new(data_name, data_value), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [data_name: data_name, data_value: data_value]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(data_name, data_value), rest}
  end
end
