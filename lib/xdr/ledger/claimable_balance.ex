defmodule Stellar.XDR.Ledger.ClaimableBalance do
  @moduledoc """
  Representation of Stellar Ledger `ClaimableBalance` type.
  """
  alias Stellar.XDR.ClaimableBalanceID

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(balance_id: ClaimableBalanceID)

  @type t :: %__MODULE__{balance_id: ClaimableBalanceID.t()}

  defstruct [:balance_id]

  @spec new(balance_id :: ClaimableBalanceID.t()) :: t()
  def new(%ClaimableBalanceID{} = balance_id),
    do: %__MODULE__{balance_id: balance_id}

  @impl true
  def encode_xdr(%__MODULE__{balance_id: balance_id}) do
    [balance_id: balance_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{balance_id: balance_id}) do
    [balance_id: balance_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [balance_id: balance_id]}, rest}} ->
        {:ok, {new(balance_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [balance_id: balance_id]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(balance_id), rest}
  end
end
