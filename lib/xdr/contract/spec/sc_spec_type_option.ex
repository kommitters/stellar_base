defmodule StellarBase.XDR.SCSpecTypeOption do
  @moduledoc """
  Representation of Stellar `SCSpecTypeOption` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(valueType: SCSpecTypeDef)

  @type valueType :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{valueType: valueType()}

  defstruct [:valueType]

  @spec new(valueType :: SCSpecTypeDef.t()) :: t()
  def new(%SCSpecTypeDef{} = valueType),
    do: %__MODULE__{valueType: valueType}

  @impl true
  def encode_xdr(%__MODULE__{valueType: valueType}) do
    [valueType: valueType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{valueType: valueType}) do
    [valueType: valueType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [valueType: valueType]}, rest}} ->
        {:ok, {new(valueType), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [valueType: valueType]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(valueType), rest}
  end
end
