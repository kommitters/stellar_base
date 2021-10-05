defmodule Stellar.XDR.Ledger.Data do
  @moduledoc """
  Representation of Stellar Ledger `Data` type.
  """
  alias Stellar.XDR.{AccountID, String64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(account_id: AccountID, data_name: String64)

  @type t :: %__MODULE__{account_id: AccountID.t(), data_name: String64.t()}

  defstruct [:account_id, :data_name]

  @spec new(account_id :: AccountID.t(), data_name :: String64.t()) :: t()
  def new(%AccountID{} = account_id, %String64{} = data_name),
    do: %__MODULE__{account_id: account_id, data_name: data_name}

  @impl true
  def encode_xdr(%__MODULE__{account_id: account_id, data_name: data_name}) do
    [account_id: account_id, data_name: data_name]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{account_id: account_id, data_name: data_name}) do
    [account_id: account_id, data_name: data_name]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [account_id: account_id, data_name: data_name]}, rest}} ->
        {:ok, {new(account_id, data_name), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [account_id: account_id, data_name: data_name]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(account_id, data_name), rest}
  end
end
