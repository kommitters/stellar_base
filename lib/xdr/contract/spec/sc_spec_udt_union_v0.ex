defmodule StellarBase.XDR.SCSpecUDTUnionV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTUnionV0` type.
  """

  alias StellarBase.XDR.{String80, String1024, String60, SCSpecUDTUnionCaseV0List}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 doc: String1024,
                 lib: String80,
                 name: String60,
                 cases: SCSpecUDTUnionCaseV0List
               )

  @type doc :: String1024.t()
  @type lib :: String80.t()
  @type name :: String60.t()
  @type cases :: SCSpecUDTUnionCaseV0List.t()

  @type t :: %__MODULE__{doc: doc(), lib: lib(), name: name(), cases: cases()}

  defstruct [:doc, :lib, :name, :cases]

  @spec new(doc :: doc(), lib :: lib(), name :: name(), cases :: cases()) :: t()
  def new(
        %String1024{} = doc,
        %String80{} = lib,
        %String60{} = name,
        %SCSpecUDTUnionCaseV0List{} = cases
      ),
      do: %__MODULE__{doc: doc, lib: lib, name: name, cases: cases}

  @impl true
  def encode_xdr(%__MODULE__{doc: doc, lib: lib, name: name, cases: cases}) do
    [doc: doc, lib: lib, name: name, cases: cases]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{doc: doc, lib: lib, name: name, cases: cases}) do
    [doc: doc, lib: lib, name: name, cases: cases]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [doc: doc, lib: lib, name: name, cases: cases]}, rest}} ->
        {:ok, {new(doc, lib, name, cases), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [doc: doc, lib: lib, name: name, cases: cases]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(doc, lib, name, cases), rest}
  end
end
