defmodule StellarBase.XDR.SignatureHint do
  @moduledoc """
  Representation of Stellar `SignatureHint` type.
  """
  alias StellarBase.XDR.Opaque4

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{hint: String.t()}

  defstruct [:hint]

  @spec new(hint :: String.t()) :: t()
  def new(hint), do: %__MODULE__{hint: hint}

  @impl true
  def encode_xdr(%__MODULE__{hint: hint}) do
    hint
    |> Opaque4.new()
    |> Opaque4.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{hint: hint}) do
    hint
    |> Opaque4.new()
    |> Opaque4.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Opaque4.decode_xdr(bytes) do
      {:ok, {%Opaque4{opaque: hint}, rest}} -> {:ok, {new(hint), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Opaque4{opaque: hint}, rest} = Opaque4.decode_xdr!(bytes)
    {new(hint), rest}
  end
end
