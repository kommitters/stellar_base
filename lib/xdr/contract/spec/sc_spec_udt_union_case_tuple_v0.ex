defmodule StellarBase.XDR.SCSpecUDTUnionCaseTupleV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTUnionCaseTupleV0` type.
  """

  alias StellarBase.XDR.{SCSpecTypeDef12, String60, String1024}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(doc: String1024, name: String60, type: SCSpecTypeDef12)

  @type doc :: String1024.t()
  @type name :: String60.t()
  @type type :: SCSpecTypeDef12.t()

  @type t :: %__MODULE__{doc: doc(), name: name(), type: type()}

  defstruct [:doc, :name, :type]

  @spec new(doc :: doc(), name :: name(), type :: type()) :: t()
  def new(%String1024{} = doc, %String60{} = name, %SCSpecTypeDef12{} = type),
    do: %__MODULE__{doc: doc, name: name, type: type}

  @impl true
  def encode_xdr(%__MODULE__{doc: doc, name: name, type: type}) do
    [doc: doc, name: name, type: type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{doc: doc, name: name, type: type}) do
    [doc: doc, name: name, type: type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [doc: doc, name: name, type: type]}, rest}} ->
        {:ok, {new(doc, name, type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [doc: doc, name: name, type: type]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(doc, name, type), rest}
  end
end
