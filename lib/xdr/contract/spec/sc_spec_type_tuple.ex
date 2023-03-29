defmodule StellarBase.XDR.SCSpecTypeTuple do
  @moduledoc """
  Representation of Stellar `SCSpecTypeTuple` type.
  """

  alias StellarBase.XDR.SCSpecTypeDefList12

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(value_types: SCSpecTypeDefList12)

  @type value_types :: SCSpecTypeDefList12.t()

  @type t :: %__MODULE__{value_types: value_types()}

  defstruct [:value_types]

  @spec new(value_types :: value_types()) :: t()
  def new(%SCSpecTypeDefList12{} = value_types),
    do: %__MODULE__{value_types: value_types}

  @impl true
  def encode_xdr(%__MODULE__{value_types: value_types}) do
    [value_types: value_types]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value_types: value_types}) do
    [value_types: value_types]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [value_types: value_types]}, rest}} ->
        {:ok, {new(value_types), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [value_types: value_types]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(value_types), rest}
  end
end
