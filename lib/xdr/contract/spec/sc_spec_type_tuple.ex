defmodule StellarBase.XDR.SCSpecTypeTuple do
  @moduledoc """
  Representation of Stellar `SCSpecTypeTuple` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef12

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(valueTypes: SCSpecTypeDef12)

  @type valueTypes :: SCSpecTypeDef12.t()

  @type t :: %__MODULE__{valueTypes: valueTypes()}

  defstruct [:valueTypes]

  @spec new(valueTypes :: SCSpecTypeDef12.t()) :: t()
  def new(%SCSpecTypeDef12{} = valueTypes),
    do: %__MODULE__{valueTypes: valueTypes}

  @impl true
  def encode_xdr(%__MODULE__{valueTypes: valueTypes}) do
    [valueTypes: valueTypes]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{valueTypes: valueTypes}) do
    [valueTypes: valueTypes]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [valueTypes: valueTypes]}, rest}} ->
        {:ok, {new(valueTypes), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [valueTypes: valueTypes]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(valueTypes), rest}
  end
end
