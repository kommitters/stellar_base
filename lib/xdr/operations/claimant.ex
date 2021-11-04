defmodule StellarBase.XDR.Claimant do
  @moduledoc """
  Representation of Stellar `PublicKey` type.
  """
  alias StellarBase.XDR.{ClaimantType, ClaimantV0}

  @behaviour XDR.Declaration

  @arms [CLAIMANT_TYPE_V0: ClaimantV0]

  @type t :: %__MODULE__{claimant: ClaimantV0.t(), type: ClaimantType.t()}

  defstruct [:claimant, :type]

  @spec new(claimant :: ClaimantV0.t(), type :: ClaimantType.t()) :: t()
  def new(%ClaimantV0{} = claimant, %ClaimantType{} = type),
    do: %__MODULE__{claimant: claimant, type: type}

  @impl true
  def encode_xdr(%__MODULE__{claimant: claimant, type: type}) do
    type
    |> XDR.Union.new(@arms, claimant)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{claimant: claimant, type: type}) do
    type
    |> XDR.Union.new(@arms, claimant)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, key}, rest}} -> {:ok, {new(key, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, key}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(key, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> ClaimantType.new()
    |> XDR.Union.new(@arms)
  end
end
