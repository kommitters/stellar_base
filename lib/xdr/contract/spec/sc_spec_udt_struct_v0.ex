defmodule StellarBase.XDR.SCSpecUDTStructV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTStructV0` type.
  """

  alias StellarBase.XDR.{String80, String1024, String60, SCSpecUDTStructFieldV040}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 doc: String1024,
                 lib: String80,
                 name: String60,
                 fields: SCSpecUDTStructFieldV040
               )

  @type doc :: String1024.t()
  @type lib :: String80.t()
  @type name :: String60.t()
  @type fields :: SCSpecUDTStructFieldV040.t()

  @type t :: %__MODULE__{doc: doc(), lib: lib(), name: name(), fields: fields()}

  defstruct [:doc, :lib, :name, :fields]

  @spec new(doc :: doc(), lib :: lib(), name :: name(), fields :: fields()) :: t()
  def new(
        %String1024{} = doc,
        %String80{} = lib,
        %String60{} = name,
        %SCSpecUDTStructFieldV040{} = fields
      ),
      do: %__MODULE__{doc: doc, lib: lib, name: name, fields: fields}

  @impl true
  def encode_xdr(%__MODULE__{doc: doc, lib: lib, name: name, fields: fields}) do
    [doc: doc, lib: lib, name: name, fields: fields]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{doc: doc, lib: lib, name: name, fields: fields}) do
    [doc: doc, lib: lib, name: name, fields: fields]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [doc: doc, lib: lib, name: name, fields: fields]}, rest}} ->
        {:ok, {new(doc, lib, name, fields), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [doc: doc, lib: lib, name: name, fields: fields]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(doc, lib, name, fields), rest}
  end
end
