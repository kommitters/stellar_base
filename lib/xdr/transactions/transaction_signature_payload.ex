defmodule StellarBase.XDR.TransactionSignaturePayload do
  @moduledoc """
  Representation of Stellar `TransactionSignaturePayload` type.
  """
  alias StellarBase.XDR.Hash
  alias StellarBase.XDR.TransactionSignaturePayloadTaggedTransaction, as: TaggedTransaction

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(network_id: Hash, tagged_transaction: TaggedTransaction)

  @type t :: %__MODULE__{network_id: Hash.t(), tagged_transaction: TaggedTransaction.t()}

  defstruct [:network_id, :tagged_transaction]

  @spec new(network_id :: Hash.t(), tagged_transaction :: TaggedTransaction.t()) :: t()
  def new(%Hash{} = network_id, %TaggedTransaction{} = tagged_transaction),
    do: %__MODULE__{network_id: network_id, tagged_transaction: tagged_transaction}

  @impl true
  def encode_xdr(%__MODULE__{network_id: network_id, tagged_transaction: tagged_transaction}) do
    [network_id: network_id, tagged_transaction: tagged_transaction]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{network_id: network_id, tagged_transaction: tagged_transaction}) do
    [network_id: network_id, tagged_transaction: tagged_transaction]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [network_id: network_id, tagged_transaction: tagged_transaction]},
        rest}} ->
        {:ok, {new(network_id, tagged_transaction), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [network_id: network_id, tagged_transaction: tagged_transaction]},
     rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(network_id, tagged_transaction), rest}
  end
end
