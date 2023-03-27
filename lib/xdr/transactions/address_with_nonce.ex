defmodule StellarBase.XDR.AddressWithNonce do
  @moduledoc """
  Representation of Stellar `AddressWithNonce` type.
  """
  alias StellarBase.XDR.{SCAddress, UInt64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(address: SCAddress, nonce: UInt64)

  @type t :: %__MODULE__{address: SCAddress.t(), nonce: UInt64.t()}

  defstruct [:address, :nonce]

  @spec new(address :: SCAddress.t(), nonce :: UInt64.t()) :: t()
  def new(%SCAddress{} = address, %UInt64{} = nonce),
    do: %__MODULE__{address: address, nonce: nonce}

  @impl true
  def encode_xdr(%__MODULE__{address: address, nonce: nonce}) do
    [address: address, nonce: nonce]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{address: address, nonce: nonce}) do
    [address: address, nonce: nonce]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [address: address, nonce: nonce]}, rest}} ->
        {:ok, {new(address, nonce), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [address: address, nonce: nonce]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(address, nonce), rest}
  end
end
