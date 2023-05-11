defmodule StellarBase.XDR.AddressWithNonce do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `AddressWithNonce` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    SCAddress,
    Uint64
  }

  @struct_spec XDR.Struct.new(
    address: SCAddress,
    nonce: Uint64
  )

  @type type_address :: SCAddress.t()
  @type type_nonce :: Uint64.t()

  @type t :: %__MODULE__{address: type_address(), nonce: type_nonce()}

  defstruct [:address, :nonce]

  @spec new(address :: type_address(), nonce :: type_nonce()) :: t()
  def new(
    %SCAddress{} = address,
    %Uint64{} = nonce
  ),
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
      error -> error
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
