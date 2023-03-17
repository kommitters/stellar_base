defmodule StellarBase.XDR.SCSpecFunctionInputV0List do
  @moduledoc """
  Representation of a Stellar `SCSpecFunctionInputV0List` list.
  """

  alias StellarBase.XDR.SCSpecFunctionInputV0

  @behaviour XDR.Declaration

  @max_length 10

  @array_type SCSpecFunctionInputV0

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{input_list: list(SCSpecFunctionInputV0.t())}

  defstruct [:input_list]

  @spec new(input_list :: list(SCSpecTypeDef.t())) :: t()
  def new(input_list),
    do: %__MODULE__{input_list: input_list}

  @impl true
  def encode_xdr(%__MODULE__{input_list: input_list}) do
    input_list
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{input_list: input_list}) do
    input_list
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {input_list, rest}} ->
        {:ok, {new(input_list), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {input_list, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(input_list), rest}
  end
end
