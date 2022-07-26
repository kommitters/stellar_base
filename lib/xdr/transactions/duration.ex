defmodule StellarBase.XDR.Duration do
  @moduledoc """
  Representation of Stellar `Duration` type.
  """
  alias StellarBase.XDR.UInt64

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: non_neg_integer()}

  defstruct [:value]

  @spec new(value :: non_neg_integer()) :: t()
  def new(value), do: %__MODULE__{value: value}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    value
    |> UInt64.new()
    |> UInt64.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    value
    |> UInt64.new()
    |> UInt64.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case UInt64.decode_xdr(bytes) do
      {:ok, {%UInt64{datum: seq_num}, rest}} -> {:ok, {new(seq_num), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%UInt64{datum: seq_num}, rest} = UInt64.decode_xdr!(bytes)
    {new(seq_num), rest}
  end
end
