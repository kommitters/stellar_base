defmodule StellarBase.XDR.SCVec do
  @moduledoc """
  Representation of Stellar `SCVec type.
  """
  alias StellarBase.XDR.SCVal
  @behaviour XDR.Declaration
  @max_length 256_000
  @array_type SCVal
  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{vector: list(SCVal.t())}

  defstruct [:vector]

  @spec new(vector :: list(SCVal.t())) :: t()
  def new(vector), do: %__MODULE__{vector: vector}

  @impl true
  def encode_xdr(%__MODULE__{vector: vector}) do
    vector
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{vector: vector}) do
    vector
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {vector, rest}} -> {:ok, {new(vector), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {vector, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(vector), rest}
  end
end
