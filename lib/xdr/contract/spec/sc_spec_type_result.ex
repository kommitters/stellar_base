defmodule StellarBase.XDR.SCSpecTypeResult do
  @moduledoc """
  Representation of Stellar `SCSpecTypeResult` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(ok_type: SCSpecTypeDef, error_type: SCSpecTypeDef)

  @type ok_type :: SCSpecTypeDef.t()
  @type error_type :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{ok_type: ok_type(), error_type: error_type()}

  defstruct [:ok_type, :error_type]

  @spec new(ok_type :: ok_type(), error_type :: error_type()) :: t()
  def new(%SCSpecTypeDef{} = ok_type, %SCSpecTypeDef{} = error_type),
    do: %__MODULE__{ok_type: ok_type, error_type: error_type}

  @impl true
  def encode_xdr(%__MODULE__{ok_type: ok_type, error_type: error_type}) do
    [ok_type: ok_type, error_type: error_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ok_type: ok_type, error_type: error_type}) do
    [ok_type: ok_type, error_type: error_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [ok_type: ok_type, error_type: error_type]}, rest}} ->
        {:ok, {new(ok_type, error_type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [ok_type: ok_type, error_type: error_type]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(ok_type, error_type), rest}
  end
end
