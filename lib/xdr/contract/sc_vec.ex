defmodule StellarBase.XDR.SCVec do
  @moduledoc """
  Representation of Stellar `SCVec` list.
  """

  alias StellarBase.XDR.SCVal

  @behaviour XDR.Declaration

  @max_length 256_000

  @array_type SCVal

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{sc_vals: list(SCVal.t())}

  defstruct [:sc_vals]

  @spec new(sc_vals :: list(SCVal.t())) :: t()
  def new(sc_vals), do: %__MODULE__{sc_vals: sc_vals}

  @impl true
  def encode_xdr(%__MODULE__{sc_vals: sc_vals}) do
    sc_vals
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_vals: sc_vals}) do
    sc_vals
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {sc_vals, rest}} -> {:ok, {new(sc_vals), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {sc_vals, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(sc_vals), rest}
  end
end
