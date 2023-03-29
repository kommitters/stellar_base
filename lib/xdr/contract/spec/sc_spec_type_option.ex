defmodule StellarBase.XDR.SCSpecTypeOption do
  @moduledoc """
  Representation of Stellar `SCSpecTypeOption` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(value_type: SCSpecTypeDef)

  @type value_type :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{value_type: value_type()}

  defstruct [:value_type]

  @spec new(value_type :: value_type()) :: t()
  def new(%SCSpecTypeDef{} = value_type),
    do: %__MODULE__{value_type: value_type}

  @impl true
  def encode_xdr(%__MODULE__{value_type: value_type}) do
    [value_type: value_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value_type: value_type}) do
    [value_type: value_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [value_type: value_type]}, rest}} ->
        {:ok, {new(value_type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [value_type: value_type]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(value_type), rest}
  end
end
