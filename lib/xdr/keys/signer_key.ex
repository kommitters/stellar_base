defmodule Stellar.XDR.SignerKey do
  @moduledoc """
  Representation of Stellar `SignerKey` type.
  """
  alias Stellar.XDR.{UInt256, SignerKeyType}

  @behaviour XDR.Declaration

  @arms [
    SIGNER_KEY_TYPE_ED25519: UInt256,
    SIGNER_KEY_TYPE_PRE_AUTH_TX: UInt256,
    SIGNER_KEY_TYPE_HASH_X: UInt256
  ]

  @type t :: %__MODULE__{signer_key: String.t(), type: atom()}

  defstruct [:signer_key, :type]

  @spec new(public_key :: UInt256.t(), type :: SignerKeyType.t() | nil) :: t()
  def new(%UInt256{} = signer_key, %SignerKeyType{} = type),
    do: %__MODULE__{signer_key: signer_key, type: type}

  @impl true
  def encode_xdr(%__MODULE__{signer_key: signer_key, type: type}) do
    type
    |> XDR.Union.new(@arms, signer_key)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{signer_key: signer_key, type: type}) do
    type
    |> XDR.Union.new(@arms, signer_key)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ xdr_union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, key}, rest}} -> {:ok, {new(key, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ xdr_union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, key}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(key, type), rest}
  end

  @spec xdr_union_spec() :: XDR.Union.t()
  defp xdr_union_spec do
    :SIGNER_KEY_TYPE_ED25519
    |> SignerKeyType.new()
    |> XDR.Union.new(@arms)
  end
end
