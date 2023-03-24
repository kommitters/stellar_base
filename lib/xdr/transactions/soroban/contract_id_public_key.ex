defmodule StellarBase.XDR.ContractIDPublicKey do
  @moduledoc """
  Representation of Stellar `ContractIDPublicKey` type.
  """
  alias StellarBase.XDR.{ContractIDPublicKeyType, Ed25519KeyWithSignature, Void}

  @behaviour XDR.Declaration

  @arms [
    CONTRACT_ID_PUBLIC_KEY_SOURCE_ACCOUNT: Void,
    CONTRACT_ID_PUBLIC_KEY_ED25519: Ed25519KeyWithSignature
  ]

  @type contract_id_public_key :: Ed25519KeyWithSignature.t() | Void.t()

  @type t :: %__MODULE__{
          contract_id_public_key: contract_id_public_key(),
          type: ContractIDPublicKeyType.t()
        }

  defstruct [:contract_id_public_key, :type]

  @spec new(
          contract_id_public_key :: contract_id_public_key(),
          type :: ContractIDPublicKeyType.t()
        ) :: t()
  def new(contract_id_public_key, %ContractIDPublicKeyType{} = type),
    do: %__MODULE__{contract_id_public_key: contract_id_public_key, type: type}

  @impl true
  def encode_xdr(%__MODULE__{contract_id_public_key: contract_id_public_key, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_id_public_key)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{contract_id_public_key: contract_id_public_key, type: type}) do
    type
    |> XDR.Union.new(@arms, contract_id_public_key)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, contract_id_public_key}, rest}} ->
        {:ok, {new(contract_id_public_key, type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, contract_id_public_key}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(contract_id_public_key, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> ContractIDPublicKeyType.new()
    |> XDR.Union.new(@arms)
  end
end
