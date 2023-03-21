defmodule StellarBase.XDR.SCSpecUDTStructFieldV040 do
  @moduledoc """
  Representation of a Stellar `SCSpecUDTStructFieldV0` list.
  """

  alias StellarBase.XDR.SCSpecUDTStructFieldV0

  @behaviour XDR.Declaration

  @max_length 40

  @array_type SCSpecUDTStructFieldV0

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{fields: list(SCSpecUDTStructFieldV0.t())}

  defstruct [:fields]

  @spec new(fields :: list(SCSpecUDTStructFieldV0.t())) :: t()
  def new(fields),
    do: %__MODULE__{fields: fields}

  @impl true
  def encode_xdr(%__MODULE__{fields: fields}) do
    fields
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{fields: fields}) do
    fields
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {fields, rest}} -> {:ok, {new(fields), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {fields, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(fields), rest}
  end
end
