defmodule StellarBase.XDR.SCMap do
  @moduledoc """
  Representation of a Stellar `Claimants` list.
  """
  alias StellarBase.XDR.SCMapEntry

  @behaviour XDR.Declaration

  @max_length 256_000

  @array_type SCMapEntry

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{claimants: list(SCMapEntry.t())}

  defstruct [:claimants]

  @spec new(claimants :: list(SCMapEntry.t())) :: t()
  def new(claimants), do: %__MODULE__{claimants: claimants}

  @impl true
  def encode_xdr(%__MODULE__{claimants: claimants}) do
    claimants
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{claimants: claimants}) do
    claimants
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {claimants, rest}} -> {:ok, {new(claimants), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {claimants, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(claimants), rest}
  end
end
