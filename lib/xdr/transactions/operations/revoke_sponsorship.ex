defmodule StellarBase.XDR.RevokeSponsorship do
  @moduledoc """
  Representation of Stellar `RevokeSponsorship` type.
  """
  alias StellarBase.XDR.{LedgerKey, RevokeSponsorshipType}
  alias StellarBase.XDR.RevokeSponsorshipSigner

  @behaviour XDR.Declaration

  @arms [
    REVOKE_SPONSORSHIP_LEDGER_ENTRY: LedgerKey,
    REVOKE_SPONSORSHIP_SIGNER: RevokeSponsorshipSigner
  ]

  @type sponsorship :: LedgerKey.t() | RevokeSponsorshipSigner.t()

  @type t :: %__MODULE__{sponsorship: sponsorship(), type: RevokeSponsorshipType.t()}

  defstruct [:sponsorship, :type]

  @spec new(sponsorship :: sponsorship(), type :: RevokeSponsorshipType.t()) :: t()
  def new(sponsorship, %RevokeSponsorshipType{} = type),
    do: %__MODULE__{sponsorship: sponsorship, type: type}

  @impl true
  def encode_xdr(%__MODULE__{sponsorship: sponsorship, type: type}) do
    type
    |> XDR.Union.new(@arms, sponsorship)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sponsorship: sponsorship, type: type}) do
    type
    |> XDR.Union.new(@arms, sponsorship)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, sponsorship}, rest}} -> {:ok, {new(sponsorship, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, sponsorship}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(sponsorship, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> RevokeSponsorshipType.new()
    |> XDR.Union.new(@arms)
  end
end
