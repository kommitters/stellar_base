defmodule StellarBase.XDR.SponsorshipDescriptor do
  @moduledoc """
  Representation of Stellar `SponsorshipDescriptor` type.
  """
  alias StellarBase.XDR.OptionalAccountID

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{sponsorship_descriptor: OptionalAccountID.t()}

  defstruct [:sponsorship_descriptor]

  @spec new(sponsorship_descriptor :: OptionalAccountID.t()) :: t()
  def new(sponsorship_descriptor), do: %__MODULE__{sponsorship_descriptor: sponsorship_descriptor}

  @impl true
  def encode_xdr(%__MODULE__{sponsorship_descriptor: sponsorship_descriptor}) do
    OptionalAccountID.encode_xdr(sponsorship_descriptor)
  end

  @impl true
  def encode_xdr!(%__MODULE__{sponsorship_descriptor: sponsorship_descriptor}) do
    OptionalAccountID.encode_xdr!(sponsorship_descriptor)
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case OptionalAccountID.decode_xdr(bytes) do
      {:ok, {%OptionalAccountID{} = sponsorship_descriptor, rest}} ->
        {:ok, {new(sponsorship_descriptor), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%OptionalAccountID{} = sponsorship_descriptor, rest} = OptionalAccountID.decode_xdr!(bytes)
    {new(sponsorship_descriptor), rest}
  end
end
