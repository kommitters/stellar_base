defmodule StellarBase.XDR.SCSpecTypeSet do
  @moduledoc """
  Representation of Stellar `SCSpecTypeSet` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(element_type: SCSpecTypeDef)

  @type element_type :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{element_type: element_type()}

  defstruct [:element_type]

  @spec new(element_type :: element_type()) :: t()
  def new(%SCSpecTypeDef{} = element_type),
    do: %__MODULE__{element_type: element_type}

  @impl true
  def encode_xdr(%__MODULE__{element_type: element_type}) do
    [element_type: element_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{element_type: element_type}) do
    [element_type: element_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [element_type: element_type]}, rest}} ->
        {:ok, {new(element_type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [element_type: element_type]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(element_type), rest}
  end
end
