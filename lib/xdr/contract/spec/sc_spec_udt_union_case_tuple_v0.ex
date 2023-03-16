defmodule StellarBase.XDR.SCSpecUDTUnionCaseTupleV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTUnionCaseTupleV0` type.
  """

  alias StellarBase.XDR.{String1024, String60}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 doc: String1024,
                 name: String60
                 #  type: SCSpecTypeDefList
               )

  @type doc :: String1024.t()
  @type name :: String60.t()
  # @type type :: SCSpecTypeDefList.t()

  @type t :: %__MODULE__{doc: doc(), name: name()}

  defstruct [:doc, :name]

  @spec new(
          doc :: String1024.t(),
          name :: String60.t()
          # type :: SCSpecTypeDefList.t()
        ) :: t()
  def new(
        %String1024{} = doc,
        %String60{} = name
        # %SCSpecTypeDefList{} = type
      ),
      do: %__MODULE__{doc: doc, name: name}

  @impl true
  def encode_xdr(%__MODULE__{doc: doc, name: name}) do
    [doc: doc, name: name]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{doc: doc, name: name}) do
    [doc: doc, name: name]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [doc: doc, name: name]}, rest}} ->
        {:ok, {new(doc, name), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [doc: doc, name: name]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(doc, name), rest}
  end
end
