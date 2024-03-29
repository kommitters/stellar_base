defmodule StellarBase.XDR.Operations.ExtendFootprintTTL do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ExtendFootprintTTL` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    ExtensionPoint,
    UInt32
  }

  @struct_spec XDR.Struct.new(
                 ext: ExtensionPoint,
                 extend_to: UInt32
               )

  @type ext_type :: ExtensionPoint.t()
  @type extend_to_type :: UInt32.t()

  @type t :: %__MODULE__{ext: ext_type(), extend_to: extend_to_type()}

  defstruct [:ext, :extend_to]

  @spec new(ext :: ext_type(), extend_to :: extend_to_type()) :: t()
  def new(
        %ExtensionPoint{} = ext,
        %UInt32{} = extend_to
      ),
      do: %__MODULE__{ext: ext, extend_to: extend_to}

  @impl true
  def encode_xdr(%__MODULE__{ext: ext, extend_to: extend_to}) do
    [ext: ext, extend_to: extend_to]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ext: ext, extend_to: extend_to}) do
    [ext: ext, extend_to: extend_to]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [ext: ext, extend_to: extend_to]}, rest}} ->
        {:ok, {new(ext, extend_to), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [ext: ext, extend_to: extend_to]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(ext, extend_to), rest}
  end
end
