defmodule StellarBase.XDR.SCSpecUDTErrorEnumV0 do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SCSpecUDTErrorEnumV0` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    String1024,
    String80,
    String60,
    SCSpecUDTErrorEnumCaseV0List50
  }

  @struct_spec XDR.Struct.new(
    doc: String1024,
    lib: String80,
    name: String60,
    cases: SCSpecUDTErrorEnumCaseV0List50
  )

  @type type_doc :: String1024.t()
  @type type_lib :: String80.t()
  @type type_name :: String60.t()
  @type type_cases :: SCSpecUDTErrorEnumCaseV0List50.t()

  @type t :: %__MODULE__{doc: type_doc(), lib: type_lib(), name: type_name(), cases: type_cases()}

  defstruct [:doc, :lib, :name, :cases]

  @spec new(doc :: type_doc(), lib :: type_lib(), name :: type_name(), cases :: type_cases()) :: t()
  def new(
    %String1024{} = doc,
    %String80{} = lib,
    %String60{} = name,
    %SCSpecUDTErrorEnumCaseV0List50{} = cases
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
      error -> error
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
