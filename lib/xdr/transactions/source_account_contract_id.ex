defmodule StellarBase.XDR.SourceAccountContractID do
  @moduledoc """
  Representation of Stellar `SourceAccountContractID` type.
  """
  alias StellarBase.XDR.{Hash, AccountID, UInt256}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(network_id: Hash, source_account: AccountID, salt: UInt256)

  @type t :: %__MODULE__{network_id: Hash.t(), source_account: AccountID.t(), salt: UInt256.t()}

  defstruct [:network_id, :source_account, :salt]

  @spec new(network_id :: Hash.t(), source_account :: AccountID.t(), salt :: UInt256.t()) :: t()
  def new(%Hash{} = network_id, %AccountID{} = source_account, %UInt256{} = salt),
    do: %__MODULE__{network_id: network_id, source_account: source_account, salt: salt}

  @impl true
  def encode_xdr(%__MODULE__{network_id: network_id, source_account: source_account, salt: salt}) do
    [network_id: network_id, source_account: source_account, salt: salt]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{network_id: network_id, source_account: source_account, salt: salt}) do
    [network_id: network_id, source_account: source_account, salt: salt]
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
            source_account: source_account,
            salt: salt
          ]
        }, rest}} ->
        {:ok, {new(network_id, source_account, salt), rest}}

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
         source_account: source_account,
         salt: salt
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(network_id, source_account, salt), rest}
  end
end
