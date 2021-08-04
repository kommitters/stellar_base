defmodule Stellar.XDR.AccountID do
  @moduledoc """
  Representation of Stellar `AccountID` type.
  """
  alias Stellar.XDR.PublicKey

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{account_id: PublicKey.t()}

  defstruct [:account_id]

  @spec new(int32 :: integer()) :: t()
  def new(%PublicKey{} = account_id), do: %__MODULE__{account_id: account_id}

  @impl true
  def encode_xdr(%__MODULE__{account_id: account_id}) do
    PublicKey.encode_xdr(account_id)
  end

  @impl true
  def encode_xdr!(%__MODULE__{account_id: account_id}) do
    PublicKey.encode_xdr!(account_id)
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case PublicKey.decode_xdr(bytes) do
      {:ok, {%PublicKey{} = account_id, rest}} -> {:ok, {new(account_id), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%PublicKey{} = account_id, rest} = PublicKey.decode_xdr!(bytes)
    {new(account_id), rest}
  end
end
