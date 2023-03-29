defmodule StellarBase.XDR.Signer do
  @moduledoc """
  Representation of Stellar `Signer` type.
  """
  alias StellarBase.XDR.{SignerKey, UInt32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(key: SignerKey, weight: UInt32)

  @type t :: %__MODULE__{key: SignerKey.t(), weight: UInt32.t()}

  defstruct [:key, :weight]

  @spec new(key :: SignerKey.t(), weight :: UInt32.t()) :: t()
  def new(%SignerKey{} = key, %UInt32{} = weight), do: %__MODULE__{key: key, weight: weight}

  @impl true
  def encode_xdr(%__MODULE__{key: key, weight: weight}) do
    [key: key, weight: weight]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{key: key, weight: weight}) do
    [key: key, weight: weight]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [key: key, weight: weight]}, rest}} ->
        {:ok, {new(key, weight), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [key: key, weight: weight]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(key, weight), rest}
  end
end
