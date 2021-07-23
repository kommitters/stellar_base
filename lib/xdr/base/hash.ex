defmodule Stellar.XDR.Hash do
  @moduledoc """
  Representation of Stellar `Hash` type.
  """
  alias Stellar.XDR.Opaque32

  @type t :: %__MODULE__{hash: binary()}

  defstruct [:hash]

  @spec new(hash :: binary()) :: t()
  def new(hash), do: %__MODULE__{hash: hash}

  @spec encode_xdr(hash :: binary()) :: {:ok, {term(), binary()}}
  defdelegate encode_xdr(hash), to: Opaque32

  @spec encode_xdr!(hash :: binary()) :: {term(), binary()}
  defdelegate encode_xdr!(hash), to: Opaque32

  @spec decode_xdr(bytes :: binary()) :: {:ok, {t(), binary()}}
  def decode_xdr(bytes) do
    with {:ok, {%Opaque32{opaque: hash}, rest}} <- Opaque32.decode_xdr(bytes) do
      {:ok, {new(hash), rest}}
    end
  end

  @spec decode_xdr!(bytes :: binary()) :: {t(), binary()}
  def decode_xdr!(bytes) do
    with {%Opaque32{opaque: hash}, rest} <- Opaque32.decode_xdr!(bytes) do
      {new(hash), rest}
    end
  end
end
