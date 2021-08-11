defmodule Stellar.XDR.UInt32 do
  @moduledoc """
  Representation of Stellar `UInt32` type.
  """
  @behaviour XDR.Declaration

  defstruct [:datum]

  @type t :: %__MODULE__{datum: non_neg_integer()}

  @spec new(uint32 :: non_neg_integer()) :: t()
  def new(uint32), do: %__MODULE__{datum: uint32}

  @impl true
  def encode_xdr(%__MODULE__{datum: uint32}) do
    XDR.UInt.encode_xdr(%XDR.UInt{datum: uint32})
  end

  @impl true
  def encode_xdr!(%__MODULE__{datum: uint32}) do
    XDR.UInt.encode_xdr!(%XDR.UInt{datum: uint32})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.UInt.decode_xdr(bytes) do
      {:ok, {%XDR.UInt{datum: uint32}, rest}} -> {:ok, {new(uint32), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.UInt{datum: uint32}, rest} = XDR.UInt.decode_xdr!(bytes)
    {new(uint32), rest}
  end
end
