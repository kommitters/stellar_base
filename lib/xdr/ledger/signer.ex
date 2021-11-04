defmodule StellarBase.XDR.Ledger.Signer do
  @moduledoc """
  Representation of Stellar Ledger `Signer` type.
  """
  alias StellarBase.XDR.{AccountID, SignerKey}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(account_id: AccountID, signer_key: SignerKey)

  @type t :: %__MODULE__{account_id: AccountID.t(), signer_key: SignerKey.t()}

  defstruct [:account_id, :signer_key]

  @spec new(account_id :: AccountID.t(), signer_key :: SignerKey.t()) :: t()
  def new(%AccountID{} = account_id, %SignerKey{} = signer_key),
    do: %__MODULE__{account_id: account_id, signer_key: signer_key}

  @impl true
  def encode_xdr(%__MODULE__{account_id: account_id, signer_key: signer_key}) do
    [account_id: account_id, signer_key: signer_key]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{account_id: account_id, signer_key: signer_key}) do
    [account_id: account_id, signer_key: signer_key]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [account_id: account_id, signer_key: signer_key]}, rest}} ->
        {:ok, {new(account_id, signer_key), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [account_id: account_id, signer_key: signer_key]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(account_id, signer_key), rest}
  end
end
