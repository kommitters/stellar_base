defmodule StellarBase.XDR.HashIDPreimageEd25519ContractID do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `HashIDPreimageEd25519ContractID` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Hash,
    Uint256
  }

  @struct_spec XDR.Struct.new(
    network_id: Hash,
    ed25519: Uint256,
    salt: Uint256
  )

  @type type_network_id :: Hash.t()
  @type type_ed25519 :: Uint256.t()
  @type type_salt :: Uint256.t()

  @type t :: %__MODULE__{network_id: type_network_id(), ed25519: type_ed25519(), salt: type_salt()}

  defstruct [:network_id, :ed25519, :salt]

  @spec new(network_id :: type_network_id(), ed25519 :: type_ed25519(), salt :: type_salt()) :: t()
  def new(
    %Hash{} = network_id,
    %Uint256{} = ed25519,
    %Uint256{} = salt
  ),
  do: %__MODULE__{network_id: network_id, ed25519: ed25519, salt: salt}

  @impl true
  def encode_xdr(%__MODULE__{network_id: network_id, ed25519: ed25519, salt: salt}) do
    [network_id: network_id, ed25519: ed25519, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{network_id: network_id, ed25519: ed25519, salt: salt}) do
    [network_id: network_id, ed25519: ed25519, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [network_id: network_id, ed25519: ed25519, salt: salt]}, rest}} ->
        {:ok, {new(network_id, ed25519, salt), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [network_id: network_id, ed25519: ed25519, salt: salt]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(network_id, ed25519, salt), rest}
  end
end
