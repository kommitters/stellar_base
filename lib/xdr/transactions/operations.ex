defmodule StellarBase.XDR.Operations do
  @moduledoc """
  Representation of a Stellar `Operation` list.
  """
  alias StellarBase.XDR.Operation

  @behaviour XDR.Declaration

  @max_length 100

  @array_type Operation

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{operations: list(Operation.t())}

  defstruct [:operations]

  @spec new(operations :: list(Operation.t())) :: t()
  def new(operations), do: %__MODULE__{operations: operations}

  @impl true
  def encode_xdr(%__MODULE__{operations: operations}) do
    operations
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{operations: operations}) do
    operations
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {operations, rest}} -> {:ok, {new(operations), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {operations, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(operations), rest}
  end
end
