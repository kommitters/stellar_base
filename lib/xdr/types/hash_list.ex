defmodule StellarBase.XDR.HashList do
  @moduledoc """
  Representation of Stellar `HashList` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.Hash

  @array_type Hash

  @array_spec %{type: @array_type}

  @type t :: %__MODULE__{items: list(Hash.t())}

  defstruct [:items]

  @spec new(items :: list(Hash.t())) :: t()
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
