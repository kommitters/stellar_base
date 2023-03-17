defmodule StellarBase.XDR.SCSpecTypeMap do
  @moduledoc """
  Representation of Stellar `SCSpecTypeMap` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(key_type: SCSpecTypeDef, value_type: SCSpecTypeDef)

  @type key_type :: SCSpecTypeDef.t()
  @type value_type :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{key_type: key_type(), value_type: value_type()}

  defstruct [:key_type, :value_type]

  @spec new(key_type :: key_type(), value_type :: value_type()) :: t()
  def new(%SCSpecTypeDef{} = key_type, %SCSpecTypeDef{} = value_type),
    do: %__MODULE__{key_type: key_type, value_type: value_type}

  @impl true
  def encode_xdr(%__MODULE__{key_type: key_type, value_type: value_type}) do
    [key_type: key_type, value_type: value_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{key_type: key_type, value_type: value_type}) do
    [key_type: key_type, value_type: value_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [key_type: key_type, value_type: value_type]}, rest}} ->
        {:ok, {new(key_type, value_type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [key_type: key_type, value_type: value_type]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(key_type, value_type), rest}
  end
end
