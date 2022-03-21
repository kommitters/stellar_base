defmodule StellarBase.XDR.SponsorshipDescriptor do
  @moduledoc """
  Representation of Stellar `SponsorshipDescriptor` type.
  """
  alias StellarBase.XDR.AccountID

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{sponsorship_descriptor: AccountID.t()}

  defstruct [:sponsorship_descriptor]

  @spec new(sponsorship_descriptor :: AccountID.t()) :: t()
  def new(sponsorship_descriptor), do: %__MODULE__{sponsorship_descriptor: sponsorship_descriptor}

  @impl true
  def encode_xdr(%__MODULE__{sponsorship_descriptor: sponsorship_descriptor}) do
    AccountID.encode_xdr(sponsorship_descriptor)
  end

  @impl true
  def encode_xdr!(%__MODULE__{sponsorship_descriptor: sponsorship_descriptor}) do
    AccountID.encode_xdr!(sponsorship_descriptor)
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case AccountID.decode_xdr(bytes) do
      {:ok, {%AccountID{} = sponsorship_descriptor, rest}} ->
        {:ok, {new(sponsorship_descriptor), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%AccountID{} = sponsorship_descriptor, rest} = AccountID.decode_xdr!(bytes)
    {new(sponsorship_descriptor), rest}
  end
end
