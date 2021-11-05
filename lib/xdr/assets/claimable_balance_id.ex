defmodule StellarBase.XDR.ClaimableBalanceID do
  @moduledoc """
  Representation of Stellar `ClaimableBalanceID` type.
  """
  alias StellarBase.XDR.{ClaimableBalanceIDType, Hash}

  @behaviour XDR.Declaration

  @arms [CLAIMABLE_BALANCE_ID_TYPE_V0: Hash]

  @type claimable_balance_id :: Hash.t()

  @type t :: %__MODULE__{claimable_balance_id: Hash.t(), type: ClaimableBalanceIDType.t()}

  defstruct [:claimable_balance_id, :type]

  @spec new(claimable_balance_id :: claimable_balance_id(), type :: ClaimableBalanceIDType.t()) ::
          t()
  def new(claimable_balance_id, %ClaimableBalanceIDType{} = type),
    do: %__MODULE__{claimable_balance_id: claimable_balance_id, type: type}

  @impl true
  def encode_xdr(%__MODULE__{claimable_balance_id: claimable_balance_id, type: type}) do
    type
    |> XDR.Union.new(@arms, claimable_balance_id)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{claimable_balance_id: claimable_balance_id, type: type}) do
    type
    |> XDR.Union.new(@arms, claimable_balance_id)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, claimable_balance_id}, rest}} ->
        {:ok, {new(claimable_balance_id, type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, claimable_balance_id}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(claimable_balance_id, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> ClaimableBalanceIDType.new()
    |> XDR.Union.new(@arms)
  end
end
