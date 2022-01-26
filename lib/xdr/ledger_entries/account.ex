defmodule StellarBase.XDR.Account do
  @moduledoc """
  Representation of Stellar `Account` type.
  """
  alias StellarBase.XDR.AccountID

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(account_id: AccountID)

  @type t :: %__MODULE__{account_id: AccountID.t()}

  defstruct [:account_id]

  @spec new(account_id :: AccountID.t()) :: t()
  def new(%AccountID{} = account_id),
    do: %__MODULE__{account_id: account_id}

  @impl true
  def encode_xdr(%__MODULE__{account_id: account_id}) do
    [account_id: account_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{account_id: account_id}) do
    [account_id: account_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [account_id: account_id]}, rest}} ->
        {:ok, {new(account_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [account_id: account_id]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(account_id), rest}
  end
end
