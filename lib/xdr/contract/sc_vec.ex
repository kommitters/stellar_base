defmodule StellarBase.XDR.SCVec do
  @moduledoc """
  Representation of Stellar `SCVec` list.
  """
  alias StellarBase.XDR.SCVal

  @behaviour XDR.Declaration

  @max_length 256_000

  @array_type SCVal

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{scvals: list(SCVal.t())}

  defstruct [:scvals]

  @spec new(scvals :: list(SCVal.t())) :: t()
  def new(scvals), do: %__MODULE__{scvals: scvals}

  @impl true
  def encode_xdr(%__MODULE__{scvals: scvals}) do
    scvals
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{scvals: scvals}) do
    scvals
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {scvals, rest}} -> {:ok, {new(scvals), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {scvals, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(scvals), rest}
  end
end
