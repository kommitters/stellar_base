defmodule Stellar.XDR.UInt64 do
  @moduledoc """
  Representation of Stellar `UInt64` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{datum: non_neg_integer()}

  defstruct [:datum]

  @spec new(uint64 :: non_neg_integer()) :: t()
  def new(uint64), do: %__MODULE__{datum: uint64}

  @impl true
  def encode_xdr(%__MODULE__{datum: uint64}) do
    XDR.HyperUInt.encode_xdr(%XDR.HyperUInt{datum: uint64})
  end

  @impl true
  def encode_xdr!(%__MODULE__{datum: uint64}) do
    XDR.HyperUInt.encode_xdr!(%XDR.HyperUInt{datum: uint64})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.HyperUInt.decode_xdr(bytes) do
      {:ok, {%XDR.HyperUInt{datum: uint64}, rest}} -> {:ok, {new(uint64), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.HyperUInt{datum: uint64}, rest} = XDR.HyperUInt.decode_xdr!(bytes)
    {new(uint64), rest}
  end
end
