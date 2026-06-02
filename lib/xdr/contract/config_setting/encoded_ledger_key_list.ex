defmodule StellarBase.XDR.EncodedLedgerKeyList do
  @moduledoc """
  Representation of Stellar `EncodedLedgerKeyList` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.EncodedLedgerKey

  @array_type EncodedLedgerKey

  @array_spec %{type: @array_type}

  @type t :: %__MODULE__{items: list(EncodedLedgerKey.t())}

  defstruct [:items]

  @spec new(items :: list(EncodedLedgerKey.t())) :: t()
  def new(items), do: %__MODULE__{items: items}

  @impl true
  def encode_xdr(%__MODULE__{items: items}) do
    items
    |> XDR.VariableArray.new(@array_type)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{items: items}) do
    items
    |> XDR.VariableArray.new(@array_type)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {items, rest}} -> {:ok, {new(items), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {items, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(items), rest}
  end
end
