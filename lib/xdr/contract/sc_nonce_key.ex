defmodule StellarBase.XDR.SCNonceKey do
  @moduledoc """
  Representation of Stellar `SCNonceKey` type.
  """
  alias StellarBase.XDR.SCAddress

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(nonce_address: SCAddress)

  @type t :: %__MODULE__{nonce_address: SCAddress.t()}

  defstruct [:nonce_address]

  @spec new(nonce_address :: SCAddress.t()) :: t()
  def new(%SCAddress{} = nonce_address),
    do: %__MODULE__{nonce_address: nonce_address}

  @impl true
  def encode_xdr(%__MODULE__{nonce_address: nonce_address}) do
    [nonce_address: nonce_address]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{nonce_address: nonce_address}) do
    [nonce_address: nonce_address]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [nonce_address: nonce_address]}, rest}} ->
        {:ok, {new(nonce_address), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [nonce_address: nonce_address]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(nonce_address), rest}
  end
end
