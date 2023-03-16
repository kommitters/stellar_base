defmodule StellarBase.XDR.SCSpecUDTStructFieldV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTStructFieldV0` type.
  """

  alias StellarBase.XDR.{String1024, String30, SCSpecTypeDef}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 doc: String1024,
                 name: String30,
                 type: SCSpecTypeDef
               )

  @type doc :: String1024.t()
  @type name :: String30.t()
  @type type :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{doc: doc(), name: name(), type: type()}

  defstruct [:doc, :name, :type]

  @spec new(
          doc :: String1024.t(),
          name :: String30.t(),
          type :: SCSpecTypeDef.t()
        ) :: t()
  def new(
        %String1024{} = doc,
        %String30{} = name,
        %SCSpecTypeDef{} = type
      ),
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
