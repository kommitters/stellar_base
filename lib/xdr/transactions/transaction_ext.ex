defmodule Stellar.XDR.TransactionExt do
  @moduledoc """
  Representation of Stellar `Ext` type.
  """
  alias Stellar.XDR.Void

  @behaviour XDR.Declaration

  @arms %{0 => Void}

  @type t :: %__MODULE__{type: non_neg_integer(), value: Void.t()}

  defstruct [:type, :value]

  @spec new() :: t()
  def new, do: %__MODULE__{type: 0, value: Void.new()}

  @impl true
  def encode_xdr(%__MODULE__{type: type, value: value}) do
    type
    |> XDR.Int.new()
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{type: type, value: value}) do
    type
    |> XDR.Int.new()
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {_decoded, rest}} -> {:ok, {new(), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {_decoded, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec, do: XDR.Union.new(XDR.Int.new(0), @arms)
end
