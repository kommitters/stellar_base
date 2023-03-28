defmodule StellarBase.XDR.Ed25519ContractID do
  @moduledoc """
  Representation of Stellar `Ed25519ContractID` type.
  """
  alias StellarBase.XDR.{Hash, UInt256}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(network_id: Hash, ed25519: UInt256, salt: UInt256)

  @type t :: %__MODULE__{network_id: Hash.t(), ed25519: UInt256.t(), salt: UInt256.t()}

  defstruct [:network_id, :ed25519, :salt]

  @spec new(network_id :: Hash.t(), ed25519 :: UInt256.t(), salt :: UInt256.t()) :: t()
  def new(%Hash{} = network_id, %UInt256{} = ed25519, %UInt256{} = salt),
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
      {:ok,
       {%XDR.Struct{
          components: [
            network_id: network_id,
            ed25519: ed25519,
            salt: salt
          ]
        }, rest}} ->
        {:ok, {new(network_id, ed25519, salt), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         network_id: network_id,
         ed25519: ed25519,
         salt: salt
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(network_id, ed25519, salt), rest}
  end
end
