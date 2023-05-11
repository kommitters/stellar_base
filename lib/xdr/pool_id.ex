defmodule StellarBase.XDR.PoolID do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `PoolID` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.Hash

  @type t :: %__MODULE__{pool_id: Hash.t()}

  defstruct [:pool_id]

  @spec new(pool_id :: Hash.t()) :: t()
  def new(%Hash{} = pool_id), do: %__MODULE__{pool_id: pool_id}

  @impl true
  def encode_xdr(%__MODULE__{pool_id: pool_id}) do
    Hash.encode_xdr(pool_id)
  end

  @impl true
  def encode_xdr!(%__MODULE__{pool_id: pool_id}) do
    Hash.encode_xdr!(pool_id)
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Hash.decode_xdr(bytes) do
      {:ok, {%Hash{} = pool_id, rest}} -> {:ok, {new(pool_id), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Hash{} = pool_id, rest} = Hash.decode_xdr!(bytes)
    {new(pool_id), rest}
  end
end
