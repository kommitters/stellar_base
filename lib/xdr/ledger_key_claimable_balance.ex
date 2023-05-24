defmodule StellarBase.XDR.LedgerKeyClaimableBalance do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `LedgerKeyClaimableBalance` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.ClaimableBalanceID

  @struct_spec XDR.Struct.new(balance_id: ClaimableBalanceID)

  @type balance_id_type :: ClaimableBalanceID.t()

  @type t :: %__MODULE__{balance_id: balance_id_type()}

  defstruct [:balance_id]

  @spec new(balance_id :: balance_id_type()) :: t()
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
