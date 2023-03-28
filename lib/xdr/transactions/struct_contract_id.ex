defmodule StellarBase.XDR.StructContractID do
  @moduledoc """
  Representation of Stellar `StructContractID` type.
  """
  alias StellarBase.XDR.{Hash, UInt256}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(network_id: Hash, contract_id: Hash, salt: UInt256)

  @type t :: %__MODULE__{network_id: Hash.t(), contract_id: Hash.t(), salt: UInt256.t()}

  defstruct [:network_id, :contract_id, :salt]

  @spec new(network_id :: Hash.t(), contract_id :: Hash.t(), salt :: UInt256.t()) :: t()
  def new(%Hash{} = network_id, %Hash{} = contract_id, %UInt256{} = salt),
    do: %__MODULE__{network_id: network_id, contract_id: contract_id, salt: salt}

  @impl true
  def encode_xdr(%__MODULE__{network_id: network_id, contract_id: contract_id, salt: salt}) do
    [network_id: network_id, contract_id: contract_id, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{network_id: network_id, contract_id: contract_id, salt: salt}) do
    [network_id: network_id, contract_id: contract_id, salt: salt]
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
            contract_id: contract_id,
            salt: salt
          ]
        }, rest}} ->
        {:ok, {new(network_id, contract_id, salt), rest}}

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
         contract_id: contract_id,
         salt: salt
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(network_id, contract_id, salt), rest}
  end
end
