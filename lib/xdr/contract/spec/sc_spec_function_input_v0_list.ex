defmodule StellarBase.XDR.SCSpecFunctionInputV0List do
  @moduledoc """
  Representation of a Stellar `SCSpecFunctionInputV0List` list.
  """

  alias StellarBase.XDR.SCSpecFunctionInputV0

  @behaviour XDR.Declaration

  @max_length 10

  @array_type SCSpecFunctionInputV0

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{inputs: list(SCSpecFunctionInputV0.t())}

  defstruct [:inputs]

  @spec new(inputs :: list(SCSpecFunctionInputV0.t())) :: t()
  def new(inputs),
    do: %__MODULE__{inputs: inputs}

  @impl true
  def encode_xdr(%__MODULE__{inputs: inputs}) do
    inputs
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{inputs: inputs}) do
    inputs
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {inputs, rest}} ->
        {:ok, {new(inputs), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {inputs, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(inputs), rest}
  end
end
