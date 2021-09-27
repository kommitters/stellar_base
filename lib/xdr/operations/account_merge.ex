defmodule Stellar.XDR.Operations.AccountMerge do
  @moduledoc """
  Representation of Stellar `AccountMerge` type.
  """
  alias Stellar.XDR.MuxedAccount

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{account: MuxedAccount.t()}

  defstruct [:account]

  @spec new(account :: MuxedAccount.t()) :: t()
  def new(%MuxedAccount{} = account), do: %__MODULE__{account: account}

  @impl true
  def encode_xdr(%__MODULE__{account: account}), do: MuxedAccount.encode_xdr(account)

  @impl true
  def encode_xdr!(%__MODULE__{account: account}), do: MuxedAccount.encode_xdr!(account)

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case MuxedAccount.decode_xdr(bytes) do
      {:ok, {%MuxedAccount{} = account, rest}} -> {:ok, {new(account), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%MuxedAccount{} = account, rest} = MuxedAccount.decode_xdr!(bytes)
    {new(account), rest}
  end
end
