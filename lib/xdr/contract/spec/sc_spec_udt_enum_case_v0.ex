defmodule StellarBase.XDR.SCSpecUDTEnumCaseV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTEnumCaseV0` type.
  """

  alias StellarBase.XDR.{String1024, String60, UInt32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(doc: String1024, name: String60, value: UInt32)

  @type doc :: String1024.t()
  @type name :: String60.t()
  @type value :: UInt32.t()

  @type t :: %__MODULE__{doc: doc(), name: name(), value: value()}

  defstruct [:doc, :name, :value]

  @spec new(doc :: String1024.t(), name :: String60.t(), value :: UInt32.t()) :: t()
  def new(%String1024{} = doc, %String60{} = name, %UInt32{} = value),
    do: %__MODULE__{doc: doc, name: name, value: value}

  @impl true
  def encode_xdr(%__MODULE__{doc: doc, name: name, value: value}) do
    [doc: doc, name: name, value: value]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{doc: doc, name: name, value: value}) do
    [doc: doc, name: name, value: value]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [doc: doc, name: name, value: value]}, rest}} ->
        {:ok, {new(doc, name, value), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [doc: doc, name: name, value: value]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(doc, name, value), rest}
  end
end
