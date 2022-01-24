defmodule StellarBase.XDR.Assets do
  @moduledoc """
  Representation of a Stellar `Assets` list.
  """
  alias StellarBase.XDR.Asset

  @behaviour XDR.Declaration

  @max_length 5

  @array_type Asset

  @array_spec %{type: @array_type, max_length: @max_length}

  @type assets :: list(Asset.t())

  @type t :: %__MODULE__{assets: assets()}

  defstruct [:assets]

  @spec new(assets :: assets()) :: t()
  def new(assets), do: %__MODULE__{assets: assets}

  @impl true
  def encode_xdr(%__MODULE__{assets: assets}) do
    assets
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{assets: assets}) do
    assets
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {assets, rest}} -> {:ok, {new(assets), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {assets, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(assets), rest}
  end
end
