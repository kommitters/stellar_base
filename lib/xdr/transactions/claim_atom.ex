defmodule Stellar.XDR.ClaimAtom do
  @moduledoc """
  Representation of Stellar `ClaimAtom` type.
  """
  alias Stellar.XDR.{
    ClaimAtom,
    ClaimAtomType,
    ClaimLiquidityAtom,
    ClaimOfferAtom,
    ClaimOfferAtomV0
  }

  @behaviour XDR.Declaration

  @arms [
    CLAIM_ATOM_TYPE_V0: ClaimOfferAtomV0,
    CLAIM_ATOM_TYPE_ORDER_BOOK: ClaimOfferAtom,
    CLAIM_ATOM_TYPE_LIQUIDITY_POOL: ClaimLiquidityAtom
  ]

  @type claim_atom :: ClaimOfferAtomV0.t() | ClaimOfferAtom.t() | ClaimLiquidityAtom.t()

  @type t :: %__MODULE__{claim_atom: claim_atom(), type: ClaimAtomType.t()}

  defstruct [:claim_atom, :type]

  @spec new(claim_atom :: claim_atom(), type :: ClaimAtomType.t()) :: t()
  def new(claim_atom, %ClaimAtomType{} = type),
    do: %__MODULE__{claim_atom: claim_atom, type: type}

  @impl true
  def encode_xdr(%__MODULE__{claim_atom: claim_atom, type: type}) do
    type
    |> XDR.Union.new(@arms, claim_atom)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{claim_atom: claim_atom, type: type}) do
    type
    |> XDR.Union.new(@arms, claim_atom)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, claim_atom}, rest}} -> {:ok, {new(claim_atom, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, claim_atom}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(claim_atom, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> ClaimAtomType.new()
    |> XDR.Union.new(@arms)
  end
end
