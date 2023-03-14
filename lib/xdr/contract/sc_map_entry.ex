defmodule StellarBase.XDR.SCMapEntry do
  @moduledoc """
  Representation of Stellar `SCMapEntry` type.
  """
  alias StellarBase.XDR.{SCVal}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(key: SCVal, val: SCVal)

  @type t :: %__MODULE__{key: SCVal.t(), val: SCVal.t()}

  defstruct [:key, :val]

  @spec new(key :: SCVal.t(), val :: SCVal.t()) :: t()
  def new(%SCVal{} = key, %SCVal{} = val),
    do: %__MODULE__{key: key, val: val}

  @impl true
  def encode_xdr(%__MODULE__{key: key, val: val}) do
    [key: key, val: val]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{key: key, val: val}) do
    [key: key, val: val]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [key: key, val: val]}, rest}} ->
        {:ok, {new(key, val), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [key: key, val: val]}, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(key, val), rest}
  end
end
