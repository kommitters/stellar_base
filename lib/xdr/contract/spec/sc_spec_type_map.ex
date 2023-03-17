defmodule StellarBase.XDR.SCSpecTypeMap do
  @moduledoc """
  Representation of Stellar `SCSpecTypeMap` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(keyType: SCSpecTypeDef, valueType: SCSpecTypeDef)

  @type keyType :: SCSpecTypeDef.t()
  @type valueType :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{keyType: keyType(), valueType: valueType()}

  defstruct [:keyType, :valueType]

  @spec new(keyType :: SCSpecTypeDef.t(), valueType :: SCSpecTypeDef.t()) :: t()
  def new(%SCSpecTypeDef{} = keyType, %SCSpecTypeDef{} = valueType),
    do: %__MODULE__{keyType: keyType, valueType: valueType}

  @impl true
  def encode_xdr(%__MODULE__{keyType: keyType, valueType: valueType}) do
    [keyType: keyType, valueType: valueType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{keyType: keyType, valueType: valueType}) do
    [keyType: keyType, valueType: valueType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [keyType: keyType, valueType: valueType]}, rest}} ->
        {:ok, {new(keyType, valueType), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [keyType: keyType, valueType: valueType]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(keyType, valueType), rest}
  end
end
