defmodule StellarBase.XDR.SCSpecTypeSet do
  @moduledoc """
  Representation of Stellar `SCSpecTypeSet` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(elementType: SCSpecTypeDef)

  @type elementType :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{elementType: elementType()}

  defstruct [:elementType]

  @spec new(elementType :: SCSpecTypeDef.t()) :: t()
  def new(%SCSpecTypeDef{} = elementType),
    do: %__MODULE__{elementType: elementType}

  @impl true
  def encode_xdr(%__MODULE__{elementType: elementType}) do
    [elementType: elementType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{elementType: elementType}) do
    [elementType: elementType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [elementType: elementType]}, rest}} ->
        {:ok, {new(elementType), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [elementType: elementType]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(elementType), rest}
  end
end
