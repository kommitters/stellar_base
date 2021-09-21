defmodule Stellar.XDR.OptionalSigner do
  @moduledoc """
  Representation of Stellar `OptionalSigner` type.
  """
  alias Stellar.XDR.Signer

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(Signer)

  @type signer :: Signer.t() | nil

  @type t :: %__MODULE__{signer: signer()}

  defstruct [:signer]

  @spec new(signer :: signer()) :: t()
  def new(signer \\ nil), do: %__MODULE__{signer: signer}

  @impl true
  def encode_xdr(%__MODULE__{signer: signer}) do
    signer
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{signer: signer}) do
    signer
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: signer}, rest}} ->
        {:ok, {new(signer), rest}}

      {:ok, {nil, rest}} ->
        {:ok, {new(), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, optional_spec \\ @optional_spec)

  def decode_xdr!(bytes, optional_spec) do
    case XDR.Optional.decode_xdr!(bytes, optional_spec) do
      {%XDR.Optional{type: signer}, rest} -> {new(signer), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
