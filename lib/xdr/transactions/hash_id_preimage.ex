defmodule StellarBase.XDR.HashIDPreimage do
  @moduledoc """
  Representation of Stellar `HashIDPreimage` type.
  """
  alias StellarBase.XDR.{
    EnvelopeType,
    OperationID,
    RevokeID,
    Ed25519ContractID,
    StructContractID,
    FromAsset,
    SourceAccountContractID,
    HashIDPreimageCreateContractArgs,
    HashIDPreimageContractAuth
  }

  @behaviour XDR.Declaration

  @arms [
    ENVELOPE_TYPE_OP_ID: OperationID,
    ENVELOPE_TYPE_POOL_REVOKE_OP_ID: RevokeID,
    ENVELOPE_TYPE_CONTRACT_ID_FROM_ED25519: Ed25519ContractID,
    ENVELOPE_TYPE_CONTRACT_ID_FROM_CONTRACT: StructContractID,
    ENVELOPE_TYPE_CONTRACT_ID_FROM_ASSET: FromAsset,
    ENVELOPE_TYPE_CONTRACT_ID_FROM_SOURCE_ACCOUNT: SourceAccountContractID,
    ENVELOPE_TYPE_CREATE_CONTRACT_ARGS: HashIDPreimageCreateContractArgs,
    ENVELOPE_TYPE_CONTRACT_AUTH: HashIDPreimageContractAuth
  ]

  @type hash_id ::
          OperationID.t()
          | RevokeID.t()
          | Ed25519ContractID.t()
          | StructContractID.t()
          | FromAsset.t()
          | SourceAccountContractID.t()
          | HashIDPreimageCreateContractArgs.t()
          | HashIDPreimageContractAuth.t()

  @type t :: %__MODULE__{hash_id: hash_id(), type: EnvelopeType.t()}

  defstruct [:hash_id, :type]

  @spec new(hash_id :: hash_id(), type :: EnvelopeType.t()) :: t()
  def new(hash_id, %EnvelopeType{} = type), do: %__MODULE__{hash_id: hash_id, type: type}

  @impl true
  def encode_xdr(%__MODULE__{hash_id: hash_id, type: type}) do
    type
    |> XDR.Union.new(@arms, hash_id)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{hash_id: hash_id, type: type}) do
    type
    |> XDR.Union.new(@arms, hash_id)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, hash_id}, rest}} -> {:ok, {new(hash_id, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, hash_id}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(hash_id, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> EnvelopeType.new()
    |> XDR.Union.new(@arms)
  end
end
