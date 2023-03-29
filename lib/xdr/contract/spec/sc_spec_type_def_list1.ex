defmodule StellarBase.XDR.SCSpecTypeDefList1 do
  @moduledoc """
  Representation of a Stellar `SCSpecTypeDef` list.
  """

  alias StellarBase.XDR.SCSpecTypeDef

  @behaviour XDR.Declaration

  @max_length 1

  @array_type SCSpecTypeDef

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{sc_spec_type_defs: list(SCSpecTypeDef.t())}

  defstruct [:sc_spec_type_defs]

  @spec new(sc_spec_type_defs :: list(SCSpecTypeDef.t())) :: t()
  def new(sc_spec_type_defs),
    do: %__MODULE__{sc_spec_type_defs: sc_spec_type_defs}

  @impl true
  def encode_xdr(%__MODULE__{sc_spec_type_defs: sc_spec_type_defs}) do
    sc_spec_type_defs
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_spec_type_defs: sc_spec_type_defs}) do
    sc_spec_type_defs
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {sc_spec_type_defs, rest}} -> {:ok, {new(sc_spec_type_defs), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {sc_spec_type_defs, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(sc_spec_type_defs), rest}
  end
end
