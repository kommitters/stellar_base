defmodule StellarBase.XDR.OperationResultList do
  @moduledoc """
  Representation of a Stellar `OperationResultList` list.
  """
  alias StellarBase.XDR.OperationResult

  @behaviour XDR.Declaration

  @array_type OperationResult

  @array_spec %{type: @array_type}

  @type t :: %__MODULE__{operations: list(OperationResult.t())}

  defstruct [:operations]

  @spec new(operations :: list(OperationResult.t())) :: t()
  def new(operations), do: %__MODULE__{operations: operations}

  @impl true
  def encode_xdr(%__MODULE__{operations: operations}) do
    operations
    |> XDR.VariableArray.new(@array_type)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{operations: operations}) do
    operations
    |> XDR.VariableArray.new(@array_type)
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
