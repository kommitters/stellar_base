defmodule StellarBase.XDR.SCSpecTypeResult do
  @moduledoc """
  Representation of Stellar `SCSpecTypeResult` type.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(okType: SCSpecTypeDef, errorType: SCSpecTypeDef)

  @type okType :: SCSpecTypeDef.t()
  @type errorType :: SCSpecTypeDef.t()

  @type t :: %__MODULE__{okType: okType(), errorType: errorType()}

  defstruct [:okType, :errorType]

  @spec new(okType :: SCSpecTypeDef.t(), errorType :: SCSpecTypeDef.t()) :: t()
  def new(%SCSpecTypeDef{} = okType, %SCSpecTypeDef{} = errorType),
    do: %__MODULE__{okType: okType, errorType: errorType}

  @impl true
  def encode_xdr(%__MODULE__{okType: okType, errorType: errorType}) do
    [okType: okType, errorType: errorType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{okType: okType, errorType: errorType}) do
    [okType: okType, errorType: errorType]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [okType: okType, errorType: errorType]}, rest}} ->
        {:ok, {new(okType, errorType), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [okType: okType, errorType: errorType]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(okType, errorType), rest}
  end
end
